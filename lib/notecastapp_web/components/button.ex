defmodule Notecastapp.Button do
	use Phoenix.Component

	def primary_button(assigns) do
		~H"""
		<div id={@id} onclick={@action} class="hover:bg-sky-200 hover:text-neutral-800 cursor-pointer bg-neutral-800 text-white rounded-2xl py-3 px-8 font-medium"><%= @title %></div>
		"""
	end

	def primary_button_route(assigns) do
		~H"""
		<a href={"#{@route}"} id={@id}  class="hover:bg-sky-200 hover:text-neutral-800 cursor-pointer bg-neutral-800 text-white rounded-2xl py-3 px-8 font-medium"><%= @title %></a>
		"""
	end

	def secondary_button(assigns) do
		~H"""
		<a href={"#{@route}"} class="hover:bg-neutral-300 bg-neutral-200 text-neutral-800 rounded-2xl py-3 px-4 font-medium"><%= @title %></a>
		"""
	end

	def small_primary_button(assigns) do
		~H"""
		<a href={"#{@route}"} class="w-full hover:bg-sky-200  rounded-full border border-neutral-800 text-neutral-800 px-2 py-0.5 font-medium"><%= @title %></a>
		"""
	end

	def small_secondary_button(assigns) do
		~H"""
		<span onclick={"#{@route}"} class="rounded-full hover:bg-neutral-300 hover:border-neutral-300 bg-neutral-200 border border-neutral-200 text-neutral-800 px-2 cursor-pointer font-medium"><%= @title %></span>
		"""
	end


end