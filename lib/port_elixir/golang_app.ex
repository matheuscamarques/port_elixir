defmodule PortElixir.GolangApp do
  use GenServer
  @process_name __MODULE__

  def start_link(init_args) do
    # you may want to register your server with `name: __MODULE__`
    # as a third argument to `start_link`
    GenServer.start_link(__MODULE__, [init_args], name: @process_name)
  end


  def init(_args) do
     go_app = Application.app_dir(:port_elixir, "priv") <> "/golang_app/golang_app"
     IO.puts(go_app)
     port   = Port.open({:spawn_executable,go_app},[:binary, :exit_status])
    # port = Port.open({:spawn, "cat"}, [:binary])
    {:ok, port}
  end

  ## Server Callbacks
  def handle_info({port,{:data, content}}, port) do
    IO.puts "Receive: #{content}"
    {:noreply, port}
  end

  def handle_cast({:command,command}, port_state) do
    IO.puts "Send Command: #{command}"
    Port.command(port_state, command <> "\n")
    {:noreply, port_state}
  end


  ## API
  def command(command) do
    GenServer.cast(@process_name, {:command, command})
  end

end
