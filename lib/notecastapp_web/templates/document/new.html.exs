div id: "editor", class: "flex space-x-32 flex-row hidden pt-12" do

  div class: "w-3/12" do
    c Sidebar, title: @folder.title, documents: @documents, folder: @folder.id
  end

  div class: "w-9/12" do
    if @folder.language == true do
      c Editor, cancel: "window.location = '/manage/folders/#{@folder.id}'", items: options(@folder) do
        slot :form do
          form_for @changeset, Routes.folder_document_path(@conn, :create, @folder.id), fn f ->
            text_input f, :title, id: "title", class: "hidden"

            text_input f, :script, id: "script", class: "hidden"

            text_input f, :voice, id: "voice", value: "test", class: "hidden"

            submit id: "submit", class: "hover:bg-sky-200 hover:text-neutral-800 bg-neutral-800 text-white rounded-2xl py-3 px-8 font-medium" do 
              "Save document"
            end
          end
        end
      end
    else
      c Editor, cancel: "window.location = '/manage/folders/#{@folder.id}'", items: %{"🔊": "#caf0cb"} do
        slot :form do
          form_for @changeset, Routes.folder_document_path(@conn, :create, @folder.id), fn f ->
            text_input f, :title, id: "title", class: "hidden"

            text_input f, :script, id: "script", class: "hidden"

            text_input f, :voice, id: "voice", value: "test", class: "hidden"

            submit id: "submit", class: "hover:bg-sky-200 hover:text-neutral-800 bg-neutral-800 text-white rounded-2xl py-3 px-8 font-medium" do 
              "Save document"
            end
          end
        end
      end
    end
  end

end

script do: """
document.addEventListener("DOMContentLoaded", function(event) { 
  let editor = document.getElementById("editor");
  editor.classList.remove("hidden");
});


const focusParent = () => {
   const html = editor.getHTML() 
   if (html === "<p>Enter some text ...</p>") {
    window.editor.commands.clearContent()
   }
}

document.addEventListener("keydown", event => {
  if (event.isComposing || event.keyCode === 9) {
    focusParent()
  }
});

const addImage = () => {
  const url = window.prompt('URL')

  if (url) {
    window.editor.chain().focus().setImage({ src: url }).run()
  }
}
"""
