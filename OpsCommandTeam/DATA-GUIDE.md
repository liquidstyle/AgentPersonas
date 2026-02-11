# Shadow6 Data Guide

> How to organize, export, and feed data to your ops team.

This guide covers what each agent needs, where it comes from, how to export it, and how to organize it in the Locker so any agent can grab what they need.

---

## The Locker: File Organization

All data lives in the `Locker/` folder. Organize by source system, not by agent — multiple agents pull from the same exports.

```
OpsCommandTeam/
└── Locker/
    ├── qbo/                          # QuickBooks Online exports
    │   ├── pl-2023-2024-2025.xlsx    # P&L by year (DONE - already have this)
    │   ├── invoices-2025.csv         # Invoice detail export
    │   ├── invoices-2024.csv
    │   ├── receivables-aging.csv     # Current A/R aging report
    │   ├── expenses-by-vendor.csv    # Vendor spend detail
    │   └── client-revenue.csv       # Revenue by customer report
    │
    ├── 3pl/                          # Custom 3PL system exports
    │   ├── receiving-log.csv         # All receiving events
    │   ├── inventory-snapshot.csv    # Current inventory by client/SKU
    │   ├── storage-map.csv          # Storage locations by client
    │   ├── shipping-manifest.csv    # Outbound shipment log
    │   ├── order-history.csv        # Order detail
    │   └── client-activity.csv      # Activity summary by client
    │
    ├── shopify/                      # shop.bandwear.com exports
    │   ├── orders.csv               # Order export
    │   ├── products.csv             # Product catalog
    │   └── customers.csv            # Customer data
    │
    ├── pipedrive/                    # CRM/sales pipeline exports
    │   ├── deals.csv                # All deals with stages
    │   ├── activities.csv           # Call/email/meeting log
    │   ├── contacts.csv             # Contact database
    │   └── lost-deals.csv           # Lost/closed deals with reasons
    │
    ├── zendesk/                      # Support ticket exports
    │   ├── tickets.csv              # All tickets
    │   └── satisfaction.csv         # CSAT scores
    │
    ├── labor/                        # Workforce data
    │   ├── timesheets.csv           # (DONE - already have 2020-2026)
    │   └── payroll-summary.csv      # Payroll by period
    │
    ├── clients/                      # Client-specific files
    │   ├── contracts/               # Rate cards, SOWs, agreements
    │   ├── fulfillment-reports/     # Client performance reports
    │   ├── charges-reports/         # Billing detail by client
    │   └── inventory-reports/       # Stock levels by client
    │
    └── reference/                    # Static reference data
        ├── rate-cards.csv           # Current pricing by service
        ├── client-roster.csv        # Master client list with services
        └── warehouse-layout.csv     # Space allocation map
```

---

## What You Already Have

| File | Location | Agent Use |
|------|----------|-----------|
| P&L 2023-2025 | `Locker/` (move to `Locker/qbo/`) | Marge, Ledger, Scout |
| Timesheets 2020-2026 | `Locker/` (move to `Locker/labor/`) | Ledger, Marge |

The timesheet data is particularly valuable — it has `jobcode_1` which maps to client names (800 Pound Gorilla Records, A Thousand Lights, Alien Fashion Show, Bandwear Shop, Swin Swinford, etc.). This means you're already tracking labor hours by client. Ledger and Marge can use this to calculate actual labor cost per client for the Client Profitability Matrix.

---

## Export Guide by Source System

### 1. QuickBooks Online

**Priority: HIGH — Marge needs this first**

| Export | How to Get It | Key Columns Needed | Feeds |
|--------|--------------|-------------------|-------|
| **Invoice Detail** | Reports > Sales > Invoice List > Export to CSV | Date, Invoice #, Customer, Item/Service, Qty, Rate, Amount, Status | Marge |
| **Revenue by Customer** | Reports > Sales > Sales by Customer Summary > Export | Customer Name, Total Revenue (by period) | Marge, Nexus |
| **A/R Aging** | Reports > Who Owes You > A/R Aging Summary > Export | Customer, Current, 1-30, 31-60, 61-90, 90+ | Marge, Nexus |
| **P&L by Month** | Reports > Business Overview > P&L > Monthly > Export | Already have annual — monthly would be more granular | Marge, Ledger |
| **Expense by Vendor** | Reports > Expenses > Expenses by Vendor > Export | Vendor, Category, Amount, Date | Ledger |

**Naming convention**: `qbo-[report-type]-[date-range].csv`
**Example**: `qbo-invoice-detail-2025.csv`

**What Marge specifically wants first**:
1. Invoice Detail for 2024 and 2025 — she needs to cross-reference invoiced items against 3PL receiving events to find unbilled work
2. Revenue by Customer — to build the Client Profitability Matrix
3. A/R Aging — to flag collection issues

---

### 2. Your Custom 3PL System

**Priority: HIGH — Ledger needs this first**

Since you built this system, you control the export format. Here's what the agents need:

#### Receiving Log
```
Columns needed:
- date_received
- client_name (or client_id)
- po_number (if applicable)
- sku_count (number of unique SKUs received)
- unit_count (total units received)
- pallet_count (if tracked)
- carton_count (if tracked)
- received_by (staff member)
- notes
- invoiced (yes/no/amount — THIS IS THE KEY COLUMN for Marge)
```
*This is the single most important export for revenue recovery. Every row where `invoiced` is blank or "no" is money left on the table.*

#### Inventory Snapshot
```
Columns needed:
- snapshot_date
- client_name
- sku
- product_name
- quantity_on_hand
- location (bin/shelf/pallet location)
- date_last_received
- date_last_shipped
- days_since_last_movement
- storage_type (pallet, shelf, bin, overstock)
```
*Ledger uses `days_since_last_movement` to build the Dead Stock Audit. Anything over 90 days with no movement gets flagged.*

#### Storage Map / Space Allocation
```
Columns needed:
- location_id (bin/shelf/pallet position)
- location_type (pallet rack, shelf, bin, floor, overstock)
- square_footage (or cubic footage)
- client_name
- sku (if single-SKU location)
- occupied (yes/no)
```
*Ledger needs this to calculate warehouse utilization — what percentage of 12,500 sq ft is generating revenue vs. sitting as free storage.*

#### Shipping Manifest / Order History
```
Columns needed:
- order_date
- ship_date
- client_name
- order_id
- order_type (e-commerce, bulk, wholesale, dropship, project/release)
- item_count
- package_count
- carrier
- shipping_cost
- shipping_charged (what the client was billed)
- destination_state (for regional analysis)
```
*Scout uses order_type to analyze the product drop vs. ongoing fulfillment mix. Marge compares shipping_cost vs. shipping_charged for margin analysis.*

#### Client Activity Summary
```
Columns needed:
- client_name
- period (month)
- orders_shipped
- units_shipped
- receiving_events
- units_received
- current_inventory_units
- storage_locations_used
- support_tickets (if tracked)
```
*This is the dashboard view. Nexus uses it for Client Health Scorecards. Marge uses it to see who's generating the most work.*

---

### 3. Shopify (shop.bandwear.com)

**Priority: MEDIUM — Scout and Blitz need this for Phase 2**

| Export | How to Get It | Feeds |
|--------|--------------|-------|
| **Orders** | Shopify Admin > Orders > Export | Scout, Blitz |
| **Products** | Shopify Admin > Products > Export | Scout |
| **Customers** | Shopify Admin > Customers > Export | Scout, Cultivator |

Shopify exports are standardized — just use the built-in Export button. Columns are pre-defined by Shopify.

**What Scout specifically wants**:
- Orders export with date range covering at least 12 months
- Product catalog with inventory levels
- Customer export for geographic and repeat-purchase analysis

---

### 4. Pipedrive

**Priority: MEDIUM — Cultivator needs this for Phase 3**

| Export | How to Get It | Key Columns | Feeds |
|--------|--------------|-------------|-------|
| **Deals** | Pipedrive > Deals > Filter: All > Export | Title, Contact, Org, Value, Stage, Status, Won/Lost Date, Lost Reason, Owner, Created Date | Cultivator, Blitz |
| **Activities** | Pipedrive > Activities > Export | Type, Subject, Deal, Contact, Date, Done, Owner | Cultivator |
| **Contacts/Orgs** | Pipedrive > Contacts > Export | Name, Org, Email, Phone, Tags, Last Activity Date | Cultivator |

**What Cultivator specifically wants**:
1. All deals — especially lost/closed ones with the Lost Reason field filled in
2. Activity log — to see when the last touchpoint was on each deal
3. Contact list with organization data — for the Upsell Map (which clients use one service but not both)

**Pro tip**: In Pipedrive, filter deals by "Lost" status and export separately as `pipedrive-lost-deals.csv`. This is the Revival Audit input.

---

### 5. Zendesk

**Priority: LOW — Nexus needs this for Phase 3**

| Export | How to Get It | Feeds |
|--------|--------------|-------|
| **Tickets** | Zendesk > Views > All Tickets > Export CSV | Nexus |
| **Satisfaction** | Zendesk > Reporting > Satisfaction > Export | Nexus |

**What Nexus specifically wants**:
- Ticket export with: Subject, Client/Requester, Category, Priority, Created Date, Resolved Date, Status, Assignee
- CSAT scores tied to clients if available

---

## Export Priority Sequence

Match the Shadow6 engagement phases:

### Phase 1: Find the Money (DO THESE FIRST)

| # | Export | From | Save As | For |
|---|--------|------|---------|-----|
| 1 | Invoice Detail 2024-2025 | QBO | `Locker/qbo/invoices-2024.csv`, `invoices-2025.csv` | Marge |
| 2 | Revenue by Customer | QBO | `Locker/qbo/client-revenue.csv` | Marge |
| 3 | Receiving Log | 3PL System | `Locker/3pl/receiving-log.csv` | Marge + Ledger |
| 4 | Inventory Snapshot | 3PL System | `Locker/3pl/inventory-snapshot.csv` | Ledger |
| 5 | Storage Map | 3PL System | `Locker/3pl/storage-map.csv` | Ledger |
| 6 | Client Charges Reports | Your reports | `Locker/clients/charges-reports/` | Marge |

*These six exports unlock the Revenue Recovery analysis and Storage Economics Report.*

### Phase 2: Build the Marketing Engine

| # | Export | From | Save As | For |
|---|--------|------|---------|-----|
| 7 | Orders (12 months) | Shopify | `Locker/shopify/orders.csv` | Scout, Blitz |
| 8 | Products | Shopify | `Locker/shopify/products.csv` | Scout |
| 9 | Deals (all) | Pipedrive | `Locker/pipedrive/deals.csv` | Blitz, Cultivator |

### Phase 3: Activate the Pipeline

| # | Export | From | Save As | For |
|---|--------|------|---------|-----|
| 10 | Lost Deals | Pipedrive | `Locker/pipedrive/lost-deals.csv` | Cultivator |
| 11 | Activities | Pipedrive | `Locker/pipedrive/activities.csv` | Cultivator |
| 12 | Contacts | Pipedrive | `Locker/pipedrive/contacts.csv` | Cultivator |
| 13 | Tickets | Zendesk | `Locker/zendesk/tickets.csv` | Nexus |
| 14 | Customer Data | Shopify | `Locker/shopify/customers.csv` | Scout |

---

## The 3PL System: Custom Export Design

Since you built the 3PL system, you can design exports specifically for Shadow6. Here's what would be most powerful:

### The "Marge Report" — Receiving vs. Billing Reconciliation
Build a query/export that joins receiving events with QBO invoices:
```
- client_name
- receiving_date
- units_received
- pallets_received
- handling_hours (if tracked)
- invoice_number (if billed)
- invoice_amount (if billed)
- billed (yes/no)
- gap_amount (estimated revenue missed if not billed)
```
This is the holy grail. If your 3PL system can produce this, Marge's Revenue Recovery Report practically writes itself.

### The "Ledger Report" — Storage Aging by Client
```
- client_name
- total_skus_stored
- total_units_stored
- oldest_item_date
- locations_occupied
- estimated_square_footage
- monthly_storage_charged
- monthly_storage_cost (calculated from warehouse operating cost / total sq ft)
- storage_gap (cost minus charged)
- days_since_oldest_item_received
```
This lets Ledger instantly identify clients using your warehouse as free storage.

### The "Nexus Report" — Client Activity Dashboard
```
- client_name
- month
- orders_shipped
- units_shipped
- units_received
- receiving_events
- avg_order_size
- on_time_rate
- error_rate
- storage_units
- total_billed
```
Client health at a glance. Nexus uses this for quarterly business reviews and churn detection.

---

## File Naming Convention

Use this pattern for consistency:

```
[source]-[report-type]-[date-range].[ext]

Examples:
  qbo-invoices-2025.csv
  qbo-pl-2023-2024-2025.xlsx
  3pl-receiving-log-2025.csv
  3pl-inventory-snapshot-2026-02.csv
  shopify-orders-2025.csv
  pipedrive-deals-all.csv
  pipedrive-lost-deals-2024-2025.csv
  zendesk-tickets-2025.csv
  labor-timesheets-2020-2026.csv
```

**Date ranges**: Use `YYYY` for annual, `YYYY-MM` for monthly snapshots, `YYYY-YYYY` for multi-year.

---

## Quick Reference: Who Eats What

| Agent | Primary Data | Secondary Data |
|-------|-------------|----------------|
| **Marge** | QBO invoices, 3PL receiving log, client charges | Rate cards, contracts, timesheets (for labor cost) |
| **Blitz** | Pipedrive deals (for win patterns), Shopify orders (for market insight) | Competitor research (web), client roster |
| **Cultivator** | Pipedrive deals + activities + contacts | Zendesk tickets (satisfaction signals), Shopify customers |
| **Nexus** | Zendesk tickets, QBO client revenue, 3PL client activity | Pipedrive notes, fulfillment reports, contracts |
| **Scout** | Shopify orders + products, industry data (web research) | Pipedrive deals (market validation), 3PL order types |
| **Ledger** | 3PL inventory + storage + receiving, timesheets, QBO costs | Warehouse layout, client contracts (storage rates) |

---

## Tips for Getting Started

1. **Don't wait for perfect data.** Start with what you can export today. Marge can work with a QBO invoice export and a rough receiving log. Perfection comes later.

2. **The 3PL system exports are your superpower.** Since you built it, you can design exports tailored exactly to what the agents need. Start with the Receiving Log — that's where the biggest revenue recovery lives.

3. **Timesheets are already gold.** The timesheet data you already have (2020-2026, 12,236 rows) has client-level jobcodes. Ledger can immediately start calculating labor cost per client using this data combined with wage rates.

4. **Monthly cadence.** Once the initial exports are done, plan a monthly data refresh. Most exports take 5 minutes. The insight compounds over time — Marge tracking month-over-month revenue leakage is more powerful than a one-time audit.

5. **Sensitive data stays in the Locker.** Employee salaries, client rates, and financial data should only live in the Locker folder. The agents reference it during analysis but the data doesn't leave your machine.

---

*"Now you know. And knowing is where the revenue is."*
