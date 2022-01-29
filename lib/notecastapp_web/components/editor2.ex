defmodule Notecastapp.Editor2 do
	use Phoenix.Component

	def editor(assigns) do
		~H"""
		<div class="bg-gradient-to-b from-white border border-neutral-200 rounded-xl p-8  flex flex-col">
		   <Notecastapp.Editor.toolbar delete={@delete} />
		   <Notecastapp.Editor.menu items={@items} />
		   <div class="mt-8 space-y-4">
			   <Notecastapp.Editor.title title={@title} />
			   <div onclick="focusParent()">
				   <Notecastapp.Editor.text />
			   </div>
		   </div>
		   <div class="mt-24 flex flex-row ml-auto sticky bottom-4 space-x-2">
			   <Notecastapp.Button.secondary_button route={@cancel} title="Cancel" />
	           <%= @render %>
		   </div>
		</div>
		"""
	end

	def read_only_editor(assigns) do
		~H"""
		<div class="bg-gradient-to-b from-white border border-neutral-200 rounded-xl p-8  flex flex-col">
		   <div class="space-y-4">
			   <p class="text-2xl text-neutral-800 placeholder-neutral-400 font-black  font-serif font-heading"><%= @title %></p>
		    	<div class="prose font-mono" onclick="window.editor.commands.extendMarkRange('highlight')"><%= @content %></div>
		   </div>
		   <div class="mt-24 flex flex-row ml-auto space-x-2 sticky bottom-4">
			   <Notecastapp.Button.secondary_button route={@edit} title="Edit" />
			   <Notecastapp.Button.primary_button action="play('audio', 0.7, 'play-button-slow', 'slow')" id="play-button-slow" route={@edit} title="Play (slow)" />
			   <Notecastapp.Button.primary_button action="play('audio', 1, 'play-button', 'normal')" id="play-button" route={@edit} title="Listen (normal)" />
			   <Notecastapp.Button.primary_button action="play('audio', 1.3, 'play-button-fast', 'fast')" id="play-button-fast" route={@edit} title="Listen (fast)" />
		   </div>
		</div>
		"""
	end

	def title(assigns) do
		~H"""
		<input placeholder="Enter document title ..." value={@title} class="font-serif font-medium font-heading text-2xl font-extrabold  text-neutral-800 placeholder-neutral-400 " id="input-title" />
		"""
	end

	def text(assigns) do
		~H"""
		<div id="" onclick="window.editor.commands.extendMarkRange('highlight')" class="prose font-mono  element" />
		"""
	end

	def toolbar(assigns) do
		~H"""
		<div class="flex flex-row items-center border-b border-neutral-300 pb-4">
		   <div class="flex flex-row space-x-0.5">
			   <Notecastapp.Button.small_secondary_button route="window.editor.commands.toggleItalic()" title="Italic" />
			   <Notecastapp.Button.small_secondary_button route="addImage()" title="Image" />
			   <Notecastapp.Button.small_secondary_button route="window.editor.commands.toggleBold()" title="Bold" />
		   </div>
		   <div class="ml-auto">
			   <%= @delete %>
		   </div>
		</div>
		"""
	end

	def menu(assigns) do
		~H"""
	    <div id="menu" class="menu flex mt-4 space-x-0.5 bg-white bg-opacity-100 backdrop-blur-lg px-2 rounded-lg border border-neutral-200 flex-row">
		    <%= for {language, color} <- @items do %>
		      <Notecastapp.Editor.menu_item color={color} language={language}  />
		    <% end %>
	    </div>
		"""
	end

	def menu_item(assigns) do
		~H"""
		<div onclick={"window.editor.commands.toggleHighlight({ color: '#{@color}' })"} class="hover:-translate-y-1 hover:scale-125 transition duration-200 cursor-pointer text-2xl text-white rounded-full">
		    <p class="font-medium"><%= @language %></p>
		</div>
		"""
	end

	def active_link(assigns) do
		~H"""
		<a href={@route} class="font-medium text-neutral-800"><%= @title %></a>
		"""
	end

	def active_sidebar_link(assigns) do
		~H"""
		<a href={@route} class="bg-neutral-300 rounded-lg px-2 py-1 font-medium text-neutral-800"><%= @title %></a>
		"""
	end

	def link(assigns) do
		~H"""
		<a href={@route} class="hover:text-neutral-800 px-2 rounded-lg hover:bg-neutral-200 py-1 font-medium text-neutral-500"><%= @title %></a>
		"""
	end
end
