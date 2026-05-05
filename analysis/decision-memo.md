# Decision Memo - SQL Decision Analysis

## Problem
Growth is positive, but leadership does not know which segment and channel mix should be prioritized to maximize margin while keeping return risk controlled.

## Method
- Built order-level analysis from transactional data (Jan-Apr 2026)
- Evaluated revenue, margin, discount policy, and return behavior
- Used window functions for trend and concentration diagnostics

## Findings
1. Enterprise + Partner is the strongest margin engine.
- High absolute revenue and stable margin percentage.
- Return rates are consistently low.

2. Paid Search drives volume but has weaker quality.
- Lower margin percentage versus Organic and Partner.
- Higher return rate, especially for SMB traffic.

3. Revenue concentration risk exists in top customers.
- A small set of customers contributes a large share of revenue.
- Concentration is manageable but requires retention safeguards.

## Recommended Actions
1. Reallocate budget from low-quality Paid Search campaigns toward Organic and Partner acquisition.
2. Tighten discount policy for SMB Paid Search orders above 10 percent.
3. Launch account expansion motions for top MidMarket and Enterprise customers to reduce concentration risk.

## Expected Business Impact
- Higher blended margin by reducing low-quality discounted volume.
- Lower return-related leakage through channel-level controls.
- Better revenue predictability via stronger retention in high-value accounts.

## Notes for Interview
If asked about trade-offs, explain that the objective was not maximizing revenue only. The strategy balances growth, margin quality, and operational risk.
