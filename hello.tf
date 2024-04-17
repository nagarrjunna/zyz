
 
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

resource "aws_instance" "myinstance" {
      ami = "ami-09298640a92b2d12c"

    instance_type = "t2.medium"
    subnet_id = aws_subnet.mysubnet.id
  
}

