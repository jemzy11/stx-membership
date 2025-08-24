# STX Membership Smart Contract

A Clarity smart contract for managing membership tokens on the Stacks blockchain.

## Overview

This contract implements a simple membership system where users can:
- Join by paying STX tokens
- Check membership status
- Get membership expiry information
- Renew existing memberships

## Features

- **Fixed Membership Fee**: 10 STX
- **Membership Duration**: 144 blocks (~1 day)
- **Automatic Expiry**: Memberships expire after the set duration
- **Renewable**: Members can renew their membership anytime

## Functions

```clarity
(join)          ;; Join as a new member
(renew)         ;; Renew existing membership
(is-member)     ;; Check if an address is a current member
(get-expiry)    ;; Get membership expiration block height
```

## Usage

### Joining as a Member
```clarity
(contract-call? .stx-membership join)
```

### Checking Membership Status
```clarity
(contract-call? .stx-membership is-member tx-sender)
```

## Development

### Prerequisites
- Clarinet
- Node.js
- Git

### Installation
1. Clone the repository
2. Install dependencies
3. Run tests using Clarinet

## Testing

Run the test suite:
```bash
clarinet test
```
