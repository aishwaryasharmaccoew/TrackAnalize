from web3 import Web3

ankr_url = 'https://rpc.ankr.com/eth'

web3 = Web3(Web3.HTTPProvider(ankr_url))
print(web3.isConnected())