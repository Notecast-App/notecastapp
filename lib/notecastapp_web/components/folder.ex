defmodule Notecastapp.Folder do
	use Phoenix.Component

	def folder(assigns) do
		~H"""
		<a href={@route} class="border p-4 bg-white hover:bg-neutral-50 rounded-xl cursor-pointer"><%= @title %></a>
		"""
	end
end