
 
provider "aws" {
  region = "ap-south-1"
  profile = "naga"
}
data "aws_ami" "myami" {
 owners = ["amazon"] 
 most_recent = true
 filter {
   name = "name"
   values = ["Windows_Server-2022-*"]
 }
}
resource "aws_vpc" "myvpc" {
  cidr_block = var.mycidr

}
resource "aws_subnet" "mysubnet" {
    cidr_block = var.mysubnetcidr
    vpc_id = aws_vpc.myvpc.id
    depends_on = [ aws_vpc.myvpc ]

}

resource "aws_instance" "myinstance" {
    ami = data.aws_ami.myami.id
    instance_type = "t2.medium"
    subnet_id = aws_subnet.mysubnet.id
  
}

