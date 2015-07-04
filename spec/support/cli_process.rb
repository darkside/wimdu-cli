require "pty"
require "expect"

class CliProcess
  def initialize(command, timeout = 1)
    @command = command
    @timeout = 1
  end

  def type(string)
    writer.write(string + "\n")
  end

  def has_output?(string_or_regex)
    result = reader.expect(string_or_regex, timeout)
    return false if result.nil?
    output << result.first
    true
  end

  def kill(signal = "TERM")
    Process.kill(signal, pid)
  end

  def wait
    reader.close
    writer.close

    _, status = Process.waitpid2(pid)
    status
  end

  def output
    @output ||= ""
  end

  private

  attr_reader :command, :timeout, :_process

  def reader
    _process[0]
  end

  def writer
    _process[1]
  end

  def pid
    _process[2]
  end

  def _process
    @_process ||= PTY.spawn(command)
  end
end
