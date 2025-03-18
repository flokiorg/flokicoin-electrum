#!/usr/bin/env python3
import argparse
import client
import json

def main():
    parser = argparse.ArgumentParser()

    conn = client.Client(("localhost", 50001))
    tx, = conn.call([client.request("blockchain.block.get_height", "a44975da31eeb14775ff4050d1daac2d9082164d13b5157f938be7f22685b0cb")])
    print(json.dumps(tx))

if __name__ == "__main__":
    main()
