resource "aws_security_group" "dbsg" {
    vpc_id = "${aws_vpc.vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }    
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        security_groups = [aws_security_group.websg.id]
    }    


}

resource "aws_db_subnet_group" "db-sb1" {
  name       = "db-sb1"
  subnet_ids = [aws_subnet.private-sub-1.id, aws_subnet.private-sub-2.id]

}

resource "aws_db_instance" "db" {
  identifier             = "db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 10
  engine                 = "mysql"
  engine_version         = "5.7"
  username               = "root"
  password               = "Password1"
  db_name                = "test"
  db_subnet_group_name   = aws_db_subnet_group.db-sb1.name
  vpc_security_group_ids = [aws_security_group.dbsg.id]
  parameter_group_name   = "default.mysql5.7"
  publicly_accessible    = false
  skip_final_snapshot    = true
}