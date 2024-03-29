div id: "editor", class: "flex space-x-32 flex-row pt-12" do

  div class: "w-3/12" do
    c Sidebar, title: @folder.title, documents: @documents, folder: @folder.id, current: @document.id
  end

  div class: "w-9/12" do
    c Display, title: @document.title, filename: @document.filename, content: raw(@document.script), items: options(@folder), edit: "window.location = '/manage/folders/#{@folder.id}/documents/#{@document.id}/edit'" do
    end
  end

end

style do: """
mark {
  cursor: pointer;
  /*background-color: transparent !important;*/
}

mark:hover {
  /*background-color: #D1EECE !important;*/
  filter: invert(1);
}
"""

script do: """
const play = (id, rate, button_id, speed) => {
    const audio = document.getElementById(id)
    audio.playbackRate = rate; 

    document.getElementById(button_id).innerHTML = `Pause (${speed})`

    audio.addEventListener('ended', () => end(id, button_id, speed))

    if (audio.paused) {
        audio.play()
        document.getElementById(button_id).innerHTML = `Pause (${speed})`
    } else {
        audio.pause()
        document.getElementById(button_id).innerHTML = `Listen (${speed})`
    }
}

const end = (id, button_id, speed) => {
    document.getElementById(button_id).innerHTML = `Listen (${speed})`
  }
"""
