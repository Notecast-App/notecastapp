defmodule NotecastappWeb.Components.Editor do
	import Temple.Component

    alias NotecastappWeb.Components.Toolbar
    alias NotecastappWeb.Components.Menu
    alias NotecastappWeb.Components.Button

	render do

		div class: "bg-gradient-to-b from-white border border-neutral-200 rounded-xl p-8 flex flex-col" do 
			c Toolbar
			c Menu, items: assigns[:items]

			div class: "mt-8 space-y-4" do
				input placeholder: "Enter document title...", value: assigns[:title], class: "font-serif font-medium font-heading text-2xl font-extrabold text-neutral-800 placeholder-neutral-400", id: "input-title" 

				div onclick: "focusParent()" do
					div onclick: "window.editor.commands.extendMarkRange('highlight')", class: "prose font-mono element"
				end
			end

			div class: "mt-24 flex flex-row ml-auto sticky bottom-4 space-x-2" do
			   c Button, onclick: assigns[:cancel], button_style: :secondary do
			   	"Cancel"
			   end
        slot :form
			end
		end

	end
end
