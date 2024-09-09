resource "aws_launch_template" "instance" {
    name_prefix = "instance"
    image_id      = "ami-0d53d72369335a9d6"
    instance_type = "t2.nano"
    security_group_names = [aws_security_group.allow_ssh_http.name]
}


resource "aws_autoscaling_group" "instance" {
    availability_zones = ["us-west-1a"]
    desired_capacity = 2
    max_size = 2
    min_size = 1

    launch_template {
      id = aws_launch_template.instance.id
      version = "$Latest"
    }
}



# resource "aws_elb" "loadbalancer" {
#     name = "instance-elb"
#     availability_zones = ["us-west-1a"]
#     security_groups = [aws_security_group.allow_ssh_http.id]
#     health_check {
#       healthy_threshold = 2
#       unhealthy_threshold = 2
#       timeout = 3
#       target = "HTTP:80/"
#       interval = 30
#     }

#     listener {
#       instance_port = 80
#       instance_protocol = "http"
#       lb_port = 80
#       lb_protocol = "http"
#     }
# }