defmodule NotecastappWeb.Components.Toolbar do
	import Temple.Component

	alias NotecastappWeb.Components.Button

	render do
		div class: "flex flex-row items-center border-b border-neutral-300 pb-4" do
			div class: "flex flex-row space-x-0.5" do
				c Button, button_style: :secondary_small, onclick: "window.editor.commands.toggleItalic()" do
					"Italic"
				end
				c Button, button_style: :secondary_small, onclick: "addImage()" do
					"Image"
				end
				c Button, button_style: :secondary_small, onclick: "window.editor.commands.toggleBold()" do
					"Bold"
				end
			end
			div class: "ml-auto" do
				c Button, button_style: :secondary_small do
					"Delete"
				end
			end
		end
	end
end
