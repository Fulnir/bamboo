defmodule Bamboo.Email do
  defstruct from: nil,
      to: nil,
      cc: nil,
      bcc: nil,
      subject: nil,
      html_body: nil,
      text_body: nil,
      headers: %{},
      assigns: %{},
      private: %{}

  alias Bamboo.Email

  defmacro __using__(_opts) do
    quote do
      import Bamboo.Email
      alias Bamboo.EmailAddress
    end
  end

  @attribute_pipe_functions [:from, :to, :cc, :bcc, :subject]

  def new_email(attrs \\ []) do
    struct(%__MODULE__{}, attrs)
  end

  for function_name <- @attribute_pipe_functions do
    def unquote(function_name)(email, attr) do
      Map.put(email, unquote(function_name), attr)
    end
  end

  def put_header(%__MODULE__{headers: headers} = email, header_name, value) do
    %{email | headers: Map.put(headers, header_name, value)}
  end

  def put_private(%Email{private: private} = email, key, value) do
    %{email | private: Map.put(private, key, value)}
  end
end
