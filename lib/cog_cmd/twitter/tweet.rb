require 'cog/command'

class CogCmd::Twitter::Tweet < Cog::Command
  def run_command
    response.content = {"tweet" => request.args[0]}
  end
end
