import boto3
import os

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table(os.environ['TABLE_NAME'])

def lambda_handler(event, context):
    print(f"Received event: {event}")

    # Sample values (you can enhance later to real billing API)
    account_id = event.get('accountId', 'default-account')
    billing_period = event.get('billingPeriod', '2024-05')
    usage_amount = event.get('usageAmount', '123')

    table.put_item(
        Item={
            'account_id': account_id,
            'billing_period': billing_period,
            'usage_amount': usage_amount
        }
    )

    return {
        'statusCode': 200,
        'body': f"Saved cost record for {account_id}"
    }
