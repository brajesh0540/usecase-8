output "repositories" {
  value = {
    for repo, resource in aws_ecr_repository.ecr : 
    repo.name => resource.repository_url
  }
  
}