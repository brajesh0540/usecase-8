output "repositories" {
  value = {
    for repo, resource in aws_ecr_repository.ecr_repos : 
    repo.name => resource.repository_url
  }
  
}