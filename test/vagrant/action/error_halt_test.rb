require File.join(File.dirname(__FILE__), '..', '..', 'test_helper')

class ErrorHaltTest < Test::Unit::TestCase
  setup do
    @klass = Vagrant::Action::ErrorHalt
    @app, @env = mock_action_data
    @instance = @klass.new(@app, @env)
  end

  should "continue the chain if no error" do
    assert !@env.error?
    @app.expects(:call).with(@env).once
    @instance.call(@env)
  end

  should "halt the chain if an error occured" do
    @env.error!(:foo)
    @app.expects(:call).never
    @instance.call(@env)
  end
end
