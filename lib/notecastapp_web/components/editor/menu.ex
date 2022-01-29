defmodule NotecastappWeb.Components.Menu do
	import Temple.Component

	render do
		div id: "menu", class: "menu flex mt-4 space-x-0.5 bg-white bg-opacity-100 backdrop-blur-lg px-2 rounded-lg border border-neutral-200 flex-row" do 
			for {language, color} <- @items do
				div onclick: "window.editor.commands.toggleHighlight({ color: '#{color}' })", class: "hover:-translate-y-1 hover:scale-125 transition duration-200 cursor-pointer text-2xl text-white rounded-full" do
					p class: "font-medium" do
						language
					end
				end
			end
		end
	end
end