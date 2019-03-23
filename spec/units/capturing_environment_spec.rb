require 'spec_helper'
require 'gitsh/capturing_environment'

describe Gitsh::CapturingEnvironment do
  describe '#captured_output' do
    it 'returns any output written to the output stream directly' do
      env = double('env')
      capturing_env = described_class.new(env)
      capturing_env.output_stream.puts 'Hello, world'
      capturing_env.output_stream.puts 'Goodbye'

      expect(capturing_env.captured_output).to eq "Hello, world\nGoodbye\n"
    end

    it 'returns any output written to the output stream via #puts' do
      env = double('env')
      capturing_env = described_class.new(env)
      capturing_env.puts 'Hello, world'
      capturing_env.puts 'Goodbye'

      expect(capturing_env.captured_output).to eq "Hello, world\nGoodbye\n"
    end

    it 'returns any output written to the output stream via #print' do
      env = double('env')
      capturing_env = described_class.new(env)
      capturing_env.print 'Hello, world. '
      capturing_env.print 'Goodbye.'

      expect(capturing_env.captured_output).to eq 'Hello, world. Goodbye.'
    end
  end

  describe 'delegations' do
    it 'delegates unknown methods to the wrapped environment' do
      return_value = double('return_value')
      env = double('env', foo: return_value)
      capturing_env = described_class.new(env)

      expect(capturing_env).to respond_to(:foo)
      expect(capturing_env.foo).to eq return_value
    end
  end
end
