# Bootstrap instructions
1. Install terraform - v0.12.6, git in a CentOS machine
2. git clone this repository
3. Export the following variables
  export AWS_ACCESS_KEY_ID=<INSERT YOUR AWS ACCESS KEY>
  export AWS_SECRET_ACCESS_KEY=<INSERT YOUR AWS SECRET KEY>
4. Run terraform apply in the git clone directory

# Assumptions
1. Entire VPC is public (for convenience sake, should not be the case in production)
2. Keypair is generated using RSA algorithm with 4096 bits
3. Availability Zone is assumed to be ap-southeast-1a (Singapore)
