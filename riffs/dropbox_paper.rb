# A clown of Dropbox Paper.
#
# Folders and documents. A folder can contain subfolders and documents.
# Subfolders can contain other subfolders and documents.
#
# Ad infinitum.

class Folder
  has_many :documents
  has_many :subfolders, class_name: 'Folder', foreign_key: 'parent_folder_id'
end

class Document
  belongs_to :folder
end

# app/views/folders/index

@folders.each do |folder|
  folder.subfolders.each do |subfolder|
    link_to folder.name, folder
  end

  folder.documents.each do |document|
    link_to document.name, document
  end
end

# app/views/folders/show

@folders.each do |folder|
  folder.subfolders.each do |subfolder|
    link_to folder.name, folder
  end

  folder.documents.each do |document|
    link_to document.name, document
  end
end
