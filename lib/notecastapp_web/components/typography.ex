defmodule Notecastapp.Typography do
	use Phoenix.Component

	def subheading(assigns) do
		~H"""
		<p class="text-neutral-500 font-medium tracking-tight"><%= @content %></p>
		"""
	end

	def h1(assigns) do
		~H"""
	     <p class="text-2xl text-neutral-800 placeholder-neutral-400 font-black font-serif font-heading"><%= @content %></p>
		"""
	end
end