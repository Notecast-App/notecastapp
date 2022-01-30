defmodule Notecastapp.Tutorial do
	alias Notecastapp.Containers
	alias Notecastapp.Parse
	alias Notecastapp.SpeechService

	def create_tutorial(user) do
    IO.puts("we got here tutorial")

		case Containers.create_folder(user, %{"title" => "How to use", "language" => true, "language_one" => "🇬🇧, en-GB-SoniaNeural", "language_two" => "🇰🇷, ko-KR-SunHiNeural"}) do
			{:ok, folder} ->
			case Containers.create_document(folder.id, %{"title" => "Welcome", "script" => "<p><strong>Introduction:</strong> This is a document. Documents can store text with <em>basic formatting</em>. You may also playback files as audio. Click the button in the bottom-right to continue by listening.</p><p><mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">Documents are grouped into folders for organisation. Folders can be English-only or multilingual. In multilingual folders, colour represents the spoken language, hence this paragraph is green and spoken in English. Notice how the introduction is not highlighted, and therefore ignored by the voice.</mark></p><p><mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">You can combine multiple languages in the same sentence. Let's learn how to greet people in Korean:</mark> <mark data-color=\"#f9d7a7\" style=\"background-color: #f9d7a7\">안녕하세요</mark>. <mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">This is particularly helpful for practicing vocabulary:</mark></p><p><mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">Apple</mark> ~&gt; <mark data-color=\"#f9d7a7\" style=\"background-color: #f9d7a7\">사과</mark></p><p><mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">Book</mark> ~&gt; <mark data-color=\"#f9d7a7\" style=\"background-color: #f9d7a7\">책</mark></p><p><mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">Cat</mark> ~&gt; <mark data-color=\"#f9d7a7\" style=\"background-color: #f9d7a7\">고양이</mark></p><p><mark data-color=\"#caf0cb\" style=\"background-color: #caf0cb\">You can practice using the editor with the exercise below...</mark></p><hr><p><strong>Give this a try...</strong></p><ol><li><p>Click \"Edit\"</p></li><li><p>Delete any text before the line \"Give this a try...\"</p></li><li><p>Highlight the Korean passage below and select \"🇰🇷\"</p></li><li><p>Click \"Save document\", then replay</p></li></ol><p>옛날에 큰 호랑이는 한 마리가 숲 속에서 살았다. 어느 날 호랑이는 배가 고파서 마을으로 갔다. 마을 옆으로 밭에서 소 한 마리가 서 있었다. 호랑이는 소를 발견했다. 호랑이는 소를 먹고 싶은데 갑자기 시끄러운 아기 울음소리를 들었다. 밭 옆에 집으로 아기가 울고 있었다. 호랑이는 집으로 다가갔다. ‘아기가 맛있을 것 같아.’ 호랑이는 생각했다.</p>", "voice" => "en-GB-MiaNeural", "filename" => "d8a445ab-d8f0-47d5-b088-70c9e6c01f87.mp3"}) do
					{:ok, document} ->
				end
		end
	end
end
