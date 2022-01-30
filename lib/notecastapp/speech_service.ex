defmodule Notecastapp.SpeechService do
  alias Notecastapp.Containers
  alias Notecastapp.Repo

  def synthesise(xml, document) do

    authenticate()

    text_to_speech(xml, document)
    |> upload()
    |> update_filename(document)

  end

  # Retrieves an access token from Microsoft
  def authenticate() do
    # if DateTime.diff(Ecto.DateTime.folder(Containers.get_active_token().inserted_at), DateTime.now("Etc/UTC")) > 540 do
    #   IO.puts "we need to remake the token"
    # end

    # IO.inspect Containers.get_active_token().inserted_at
    # IO.inspect DateTime.diff(DateTime.from_naive!(Containers.get_active_token().inserted_at, "Etc/UTC"), DateTime.utc_now(), :second)

    if Containers.get_active_token() do
      if DateTime.diff(DateTime.from_naive!(Containers.get_active_token().inserted_at, "Etc/UTC"), DateTime.utc_now(), :second) < -570 do
          case HTTPoison.post(
                 "https://#{System.get_env("REGION_IDENTIFIER")}.api.cognitive.microsoft.com/sts/v1.0/issueToken/",
                 [],
                 [{"Ocp-Apim-Subscription-Key", System.get_env("SUBSCRIPTION_KEY")}]
               ) do
            {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
              Containers.delete_token(Containers.get_active_token())
              Containers.create_token(%{"value" => body})
          end
      end
    else
      case HTTPoison.post(
             "https://#{System.get_env("REGION_IDENTIFIER")}.api.cognitive.microsoft.com/sts/v1.0/issueToken/",
             [],
             [{"Ocp-Apim-Subscription-Key", System.get_env("SUBSCRIPTION_KEY")}]
           ) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          Containers.create_token(%{"value" => body})
      end
    end

  end

  # Generate the audio output
  def text_to_speech(xml, document) do
    if String.length(xml) > 0 do
      case HTTPoison.post(
             "https://#{System.get_env("REGION_IDENTIFIER")}.tts.speech.microsoft.com/cognitiveservices/v1",
             "<speak version='1.0' xml:lang='en-US'>" <> xml <> "</speak>",
             [
               {"Authorization", "Bearer #{Containers.get_active_token().value}"},
               {"Content-Type", "application/ssml+xml"},
               {"X-Microsoft-OutputFormat", "audio-48khz-192kbitrate-mono-mp3"},
               {"User-Agent", "Logpod"}
             ]
           ) do
        {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
          body
      end
    else
        ""
    end
  end

  # Upload the generated audio output
  def upload(output) do
    filename = UUID.uuid4()
    ExAws.S3.put_object("notecast-bucket", "folders/#{filename}.mp3", output) |> ExAws.request!()
    filename
  end

  def update_filename(filename, document) do
    IO.puts("got here 222")
    Containers.update_document(document, %{filename: filename <> ".mp3"})
  end
end
