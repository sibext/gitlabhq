require 'fileutils'

print "Unpacking seed repository..."

SEED_REPO = 'seed_project.tar.gz'
REPO_PATH = File.join(Rails.root, 'tmp', 'repositories')

# Make whatever directories we need to make
FileUtils.mkdir_p(REPO_PATH)

# Copy the archive to the repo path
FileUtils.cp(File.join(Rails.root, 'spec', SEED_REPO), REPO_PATH)

# chdir to the repo path
FileUtils.cd(REPO_PATH) do
  # Extract the archive
  `tar -xf #{SEED_REPO}`

  # Remove the copy
  FileUtils.rm(SEED_REPO)
end

puts ' done.'
