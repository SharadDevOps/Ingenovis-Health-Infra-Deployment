# IP Plan — Ingenovis Health Platform

**Supernet:** `10.72.0.0/16` — 65,536 IPs  
**Zone structure:** 4 × /18 workload zones (16,384 IPs each, 25% of /16)  
**Environment sizing:** Dev/QA = /22 (1,024 IPs) · PreProd = /21 (2,048 IPs) · Prod = /20 (4,096 IPs)

---

## Zone 1 — Platform `10.72.0.0/18`

| VNet / Allocation     | CIDR              | IPs    |
|-----------------------|-------------------|--------|
| Hub VNet              | `10.72.0.0/20`    | 4,096  |
| Shared Services VNet  | `10.72.16.0/20`   | 4,096  |
| Reserved (growth)     | `10.72.32.0/19`   | 8,192  |

---

## Zone 2 — AI Matching 1 `10.72.64.0/18`

| Environment       | CIDR              | IPs    |
|-------------------|-------------------|--------|
| Dev               | `10.72.64.0/22`   | 1,024  |
| QA                | `10.72.68.0/22`   | 1,024  |
| PreProd           | `10.72.72.0/21`   | 2,048  |
| Prod              | `10.72.80.0/20`   | 4,096  |
| Reserved (growth) | `10.72.96.0/19`   | 8,192  |

---

## Zone 3 — AI Matching 2 `10.72.128.0/18`

| Environment       | CIDR               | IPs    |
|-------------------|--------------------|--------|
| Dev               | `10.72.128.0/22`   | 1,024  |
| QA                | `10.72.132.0/22`   | 1,024  |
| PreProd           | `10.72.136.0/21`   | 2,048  |
| Prod              | `10.72.144.0/20`   | 4,096  |
| Reserved (growth) | `10.72.160.0/19`   | 8,192  |

---

## Zone 4 — Analytics + Billing `10.72.192.0/18`

### Analytics

| Environment   | CIDR               | IPs    |
|---------------|--------------------|--------|
| Dev           | `10.72.192.0/22`   | 1,024  |
| QA            | `10.72.196.0/22`   | 1,024  |
| PreProd       | `10.72.200.0/21`   | 2,048  |
| Prod          | `10.72.208.0/20`   | 4,096  |

### Billing

| Environment   | CIDR               | IPs    |
|---------------|--------------------|--------|
| Dev           | `10.72.224.0/22`   | 1,024  |
| QA            | `10.72.228.0/22`   | 1,024  |
| PreProd       | `10.72.232.0/21`   | 2,048  |
| Prod          | `10.72.240.0/20`   | 4,096  |

> **Note:** Zone 4 has no reserved buffer — Analytics and Billing together fill the /18 exactly.  
> If a third workload is added to this zone, expand to a /15 supernet (`10.72.0.0/15`) and use `10.73.x.x` for overflow.

---

## CIDR Validity Reference

All blocks are aligned to their size boundary and tile the /16 with no gaps or overlaps.

| Zone        | /18 Range                         | Ends at          |
|-------------|-----------------------------------|------------------|
| Platform    | `10.72.0.0` → `10.72.63.255`     | End of first /18 |
| AI Match 1  | `10.72.64.0` → `10.72.127.255`   | End of second /18|
| AI Match 2  | `10.72.128.0` → `10.72.191.255`  | End of third /18 |
| Analytics + Billing | `10.72.192.0` → `10.72.255.255` | End of /16 |

---

## Design Decisions

- **Azure CNI Overlay required** for Dev/QA spoke VNets — pods use a separate overlay CIDR, only nodes consume VNet IPs. Traditional Azure CNI (flat) would require /20 even for Dev.
- **Hub and Shared retain /20** — Hub hosts Azure Firewall (`/26` mandatory subnet), Bastion (`/26`), and VPN Gateway (`/27`), which together consume significant address space.
- **50% reservation in Zones 1–3** — each workload /18 holds half its IPs in reserve for brand expansion, additional environments, or peering requirements.
- **Subnet allocation is tracked separately** — this document covers VNet CIDRs only. Subnet breakdown per VNet is designed incrementally as each layer is built.