output "s3_object_url" {
    value = "https://${aws_s3_bucket.first.bucket}.s3.${var.aws_region}.amazonaws.com/${aws_s3_object.image.key}"
}



#this will produce  
#https://my-bucket-name.s3.us-east-1.amazonaws.com/folder/myFile.txt