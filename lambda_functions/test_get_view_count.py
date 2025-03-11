import unittest
from unittest.mock import patch, MagicMock
from decimal import Decimal
import json
import os
from moto import mock_dynamodb
import boto3



class TestGetViewCount(unittest.TestCase):

    @mock_dynamodb
    def setUp(self):
        # Set up the mock DynamoDB table
        self.dynamodb = boto3.resource('dynamodb', region_name=os.getenv('AWS_REGION'))
        self.table = self.dynamodb.create_table(
            TableName=os.getenv('DYNAMODB_TABLE'),
            KeySchema=[
                {
                    'AttributeName': 'website',
                    'KeyType': 'HASH'
                }
            ],
            AttributeDefinitions=[
                {
                    'AttributeName': 'website',
                    'AttributeType': 'S'
                }
            ],
            ProvisionedThroughput={
                'ReadCapacityUnits': 5,
                'WriteCapacityUnits': 5
            }
        )
        self.table.put_item(Item={'website': 'resume_website', 'viewCount': Decimal(0)})

    @mock_dynamodb
    def test_lambda_handler(self):
        # Mock the event and context
        event = {}
        context = {}

        # Call the Lambda function
        response = get_view_count.lambda_handler(event, context)

        # Check the response
        self.assertEqual(response['statusCode'], 200)
        body = json.loads(response['body'])
        self.assertIn('viewCount', body)
        self.assertEqual(body['viewCount'], 0)

    @mock_dynamodb
    def test_lambda_handler_error(self):
        # Mock the event and context
        event = {}
        context = {}

        # Simulate an error by deleting the table
        self.table.delete()

        # Call the Lambda function
        response = get_view_count.lambda_handler(event, context)

        # Check the response
        self.assertEqual(response['statusCode'], 500)
        self.assertIn('error', response['body'])

if __name__ == '__main__':
    unittest.main()