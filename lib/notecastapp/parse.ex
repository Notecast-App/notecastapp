defmodule Notecastapp.Parse do
  alias Notecastapp.Audio
  alias Notecastapp.Repo
  alias Floki

  def parse(document, folder) do
    {:ok, html} = Floki.parse_document(document.script)

    xml =
      Enum.map_join(html |> Floki.find("mark"), " ", fn el ->
        IO.inspect(el |> Floki.text())

        case el |> Floki.attribute("data-color") do
          ["#caf0cb"] ->
            "<voice name='#{List.last(String.split(folder.language_one, ","))}'>#{el |> Floki.text()}</voice>"

          _ ->
            "<voice name='#{List.last(String.split(folder.language_two, ","))}'>#{el |> Floki.text()}</voice>"
        end
      end)

    # Remember to remove this
    IO.inspect(xml)

    xml
  end
end
