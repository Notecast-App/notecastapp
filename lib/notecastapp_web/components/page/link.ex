defmodule NotecastappWeb.Components.Link do
	import Temple.Component

	def style(:active), do: "font-medium text-neutral-800"
	def style(:inactive), do: "hover:text-neutral-800 px-2 rounded-lg hover:bg-neutral-200 py-1 font-medium text-neutral-500"
    def style(:sidebar), do: "bg-neutral-300 rounded-lg px-2 py-1 font-medium text-neutral-800"

    render do
    	a href: assigns[:route], class: "#{style(@link_style)} cursor-pointer" do
    		slot :default
    	end
    end
end
