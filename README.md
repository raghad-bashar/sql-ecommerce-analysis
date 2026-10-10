# E-commerce Sales Analysis with SQL

## About
تحليل مبيعات متجر إلكتروني باستخدام SQL (SQLite)، على 3 جداول:
products، shop_customers، shop_orders.

## Questions & Findings
1. **إجمالي الإيرادات:** 4,835
2. **الإيرادات لكل فئة:** Electronics 4,110 (85%) | Accessories 725 (15%)
3. **أعلى 3 عملاء:** Sara (1,320)، Lina (1,210)، Dana (700)
4. **الإيرادات الشهرية:** أعلى شهر مارس (1,460)، وأقل شهر فبراير (800)
5. **عملاء سجّلوا وما اشتروا:** Hala
6. **أكتر منتج لكل مدينة:** عمّان تعادل بين Mouse وHeadphones (3 لكل منهما)
7. **عملاء فوق المتوسط:** Sara، Lina، Dana
8. **حجم الطلبات:** 3 Large، 8 Medium، 5 Small

## SQL Skills Used
JOIN, LEFT JOIN, GROUP BY, CASE WHEN, Subqueries,
CTE, Window Functions (RANK), strftime

## Recommendations
- التركيز على الإلكترونيات لأنها تجيب معظم الإيراد
- حملة لإعادة استهداف العملاء اللي سجّلوا وما اشتروا
