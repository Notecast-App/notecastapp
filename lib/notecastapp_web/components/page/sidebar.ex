defmodule NotecastappWeb.Components.Sidebar do
  import Temple.Component

  alias NotecastappWeb.Components.Button
  alias NotecastappWeb.Components.Link

  render do
    div class: "sticky top-8" do

      div class: "flex flex-col h-full" do

        div do
          c Button, button_style: :primary_small do
            "All folders"
          end
        end

        div class: "mt-12 items-center flex flex-row border-b border-neutral-400 pb-4" do 
          p class: "font-black text-xl text-neutral-800 font-serif" do
            assigns[:title]
          end

          div class: "ml-auto" do
            c Button, button_style: :primary_small do
              "+ New"
            end
          end
        end


        div class: "flex flex-col mt-4 space-y-1" do
          for document <- @documents do
            if document.id == assigns[:current] do
              c Link, link_style: :sidebar do
                document.title
              end
            else 
              c Link, link_style: :inactive do
                document.title
              end
            end
          end
        end

      end

    end
  end
end
