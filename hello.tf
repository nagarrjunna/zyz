
 
provider "aws" {
  region = "ap-south-1"
  profile = "naga"
}

resource "aws_vpc" "myvpc" {
  cidr_block = var.mycidr

}
resource "aws_subnet" "mysubnet" {
    cidr_block = var.mysubnetcidr
    vpc_id = aws_vpc.myvpc.id
    depends_on = [ aws_vpc.myvpc ]

}
data "aws_ami" "myami" {
 owners = ["amazon"] 
 most_recent = true
 filter {
   name = "name"
   values = ["Windows_Server-2022-*"]
 }
}
resource "aws_instance" "myinstance" {
    ami = data.aws_ami.myami
    instance_type = "t2.medium"
  
}

