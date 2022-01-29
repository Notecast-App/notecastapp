defmodule NotecastappWeb.Components.Link do
	import Temple.Component

	def style(:active), do: "font-medium text-neutral-800"
	def style(:inactive), do: "hover:bg-sky-200 hover:text-neutral-800 cursor-pointer
    bg-neutral-800 text-white rounded-2xl py-3 px-8 font-medium"
    def style(:sidebar), do: "bg-neutral-300 rounded-lg px-2 py-1 font-medium text-neutral-800"

    render do
    	a class: style(@link_style) do
    		slot :default
    	end
    end
end