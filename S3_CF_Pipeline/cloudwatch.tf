resource "aws_cloudwatch_log_group" "log_group" {
  name = "${var.Project_Name}-log"
}

resource "aws_cloudwatch_log_stream" "stream" {
  name           = "${var.Project_Name}-build-log"
  log_group_name = aws_cloudwatch_log_group.log_group.name
}