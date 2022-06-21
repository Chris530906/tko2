resource "aws_security_group" "websg" {
    vpc_id = "${aws_vpc.vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"        
        cidr_blocks = ["0.0.0.0/0"]
    }   
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }    

}


resource "aws_instance" "web" {
    depends_on = [aws_instance.db]
    ami = "ami-067f8db0a5c2309c0"
    instance_type = "t2.small"
    subnet_id = "${aws_subnet.public-sub-1.id}"
    vpc_security_group_ids = ["${aws_security_group.websg.id}"]
    key_name = "tko-cfox-key"

    tags = {
        Name = "Web-VM"
    }

}