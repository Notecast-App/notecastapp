defmodule NotecastappWeb.Components.Display do
  import Temple.Component

  alias NotecastappWeb.Components.Toolbar
  alias NotecastappWeb.Components.Menu
  alias NotecastappWeb.Components.Button

  render do
    div class: "bg-gradient-to-b from-white border border-neutral-200 rounded-xl p-8 flex flex-col" do
      div class: "space-y-4" do

        p class: "text-2xl text-neutral-800 placeholder-neutral-400 font-black  font-serif font-heading" do assigns[:title] end

        div onclick: "window.editor.commands.extendMarkRange('highlight')", class: "prose font-mono" do
          assigns[:content]
        end

      end

      div class: "mt-24 flex flex-row ml-auto space-x-2 sticky bottom-4" do
        c Button, button_style: :secondary, onclick: assigns[:edit] do
          "Edit"
        end

        c Button, id: "play-button-slow", button_style: :primary, onclick: "play('audio', 0.7, 'play-button-slow', 'slow')" do
          "Listen (slow)"
        end

        c Button, id: "play-button", button_style: :primary, onclick: "play('audio', 1, 'play-button', 'normal')" do
          "Listen (normal)"
        end

        c Button, id: "play-button-fast", button_style: :primary, onclick: "play('audio', 1.3, 'play-button-fast', 'fast')" do
          "Listen (fast)"
        end
      end

      audio src: "https://notecast-bucket.s3.us-east-2.amazonaws.com/folders/#{assigns[:filename]}", controls: true, class: "hidden", id: "audio" 

    end
  end
end

