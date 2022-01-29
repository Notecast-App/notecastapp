defmodule NotecastappWeb.Components.Button do 
	import Temple.Component

	def style(:primary), do: "hover:bg-sky-200 hover:text-neutral-800 
    bg-neutral-800 text-white rounded-2xl py-3 px-8 font-medium"
    def style(:secondary), do: "hover:bg-neutral-300 bg-neutral-200 text-neutral-800 rounded-2xl py-3 px-4 font-medium"
    def style(:primary_small), do: "w-full hover:bg-sky-200  rounded-full border border-neutral-800 text-neutral-800 px-2 py-0.5 font-medium"
    def style(:secondary_small), do: "rounded-full hover:bg-neutral-300 hover:border-neutral-300 bg-neutral-200 border border-neutral-200 text-neutral-800 px-2 font-medium"

	render do
		div id: assigns[:id], class: "cursor-pointer #{style(@button_style)}", onclick: assigns[:onclick] do
			slot :default
		end
	end

end