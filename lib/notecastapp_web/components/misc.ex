defmodule Notecastapp.Misc do
	use Phoenix.Component

	def sidebar(assigns) do
		~H"""
		<div class="sticky top-8">
			<div class="flex flex-col h-full">
				<div>
				   <Notecastapp.Button.small_primary_button route={"/manage/folders/"} title="All folders" />
			   </div>
			   <div class="mt-12 items-center flex flex-row border-b border-neutral-400 pb-4">
			   <p class="font-black text-xl text-neutral-800 font-serif"><%= @title %></p>
				   <div class="ml-auto">
				   <Notecastapp.Button.small_primary_button route={"/manage/folders/#{@folder}/documents/new"} title="+ New" />
				   </div>
			   </div>
			   <div class="flex flex-col mt-4 space-y-1">
				   <%= for document <- @documents do %>
				      <%= if document.id == @current do %>
					      <Notecastapp.Editor.active_sidebar_link route={"/manage/folders/#{@folder}/documents/#{document.id}"} title={document.title} />
				      <%= else %>
					      <Notecastapp.Editor.link route={"/manage/folders/#{@folder}/documents/#{document.id}"} title={document.title} />
				      <%= end %>
				   <% end %>
			   </div>
			</div>
		</div>
		"""
	end

	def divider(assigns) do
		~H"""
		<hr class="border-neutral-800" />
		"""
	end
end
