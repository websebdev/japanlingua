def create_sentences_for_situation(situation, sentences_data)
  sentences_data.each do |sentence_data|
    return if situation.sentences.find { |sentence| sentence.content == sentence_data['content'] }.present?

    sentence = situation.sentences.new(
      character_id: sentence_data['character_id'],
      content: sentence_data['content']
    )
    sentence.generate_translation_and_words_using_ai!
    sentence.generate_audio!
  end
end

def create_situations_for_context(context, situations_data)
  situations_data.each do |situation_data|
    situation = context.situations.find_or_create_by!(title: situation_data['title']) do |s|
      s.description = situation_data['description']
      s.difficulty_level =  situation_data['difficulty_level']
    end
    create_sentences_for_situation(situation, situation_data['sentences'])
  end
end

def seed_from_json(file_path)
  json_data = JSON.parse(File.read(file_path))
  context = Context.find_or_create_by!(name: json_data['name'])
  create_situations_for_context(context, json_data['situations'])
end

# Seed data from all JSON files in the seeds_data directory
Dir[Rails.root.join('db', 'seeds_data', "contexts", '*.json')].each do |file|
  seed_from_json(file)
end
