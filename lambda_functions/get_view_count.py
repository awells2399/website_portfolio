import boto3
import json
from decimal import Decimal

print('Loading function')
# Initialize a session using Amazon DynamoDB
dynamo = boto3.resource('dynamodb')
# Specify the table
table = dynamo.Table('resume-website-count')


def decimal_default(obj):
    if isinstance(obj, Decimal):
        return float(obj)
    raise TypeError

def respond(err, res=None):
    return {
        'statusCode': '400' if err else '200',
        'body': str(err) if err else json.dumps(res, default=decimal_default),
        'headers': {
             "Access-Control-Allow-Origin": "*",  # Or specify a domain instead of '*'
            "Access-Control-Allow-Methods": "GET, POST, OPTIONS",
            "Access-Control-Allow-Headers": "Content-Type, Authorization"
        },
    }

def lambda_handler(event, context):
    # Get website view count and update it
    try:
        item = table.update_item(
            Key={
                'website': "resume_website"
            },
            UpdateExpression="set viewCount = viewCount + :val",
            ExpressionAttributeValues={
                ':val': Decimal(1)
            },
            ReturnValues="UPDATED_NEW"
        )

        return respond(None, item['Attributes'])

    except Exception as e:
        return respond(e, None)