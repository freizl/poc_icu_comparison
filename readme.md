
# Table of Contents

1.  [The Problem](#orgf843f0b)
2.  [Troubleshooting](#org451d3e6)



<a id="orgf843f0b"></a>

# The Problem

The following query yields different in different Operation System. I did some google search and sounds like it is related to Locale/Collate settings.

    SELECT ARRAY(SELECT UNNEST(ARRAY['id', 'organization_id', 'locked_by', 'lock_reasons', 'lock_note', 'lock_source', 'sent_notification_emails', 'created_at']) ORDER BY 1);

-   with `Collate "C"`, I got result
    
        {created_at,id,lock_note,lock_reasons,lock_source,locked_by,organization_id,sent_notification_emails}

-   with `Collate "UTF-8"`, I got result
    
        {created_at,id,locked_by,lock_note,lock_reasons,lock_source,organization_id,sent_notification_emails}


<a id="org451d3e6"></a>

# Troubleshooting

Looks like the break happens on whether `_` is smaller than `e` or not.
Presumably, it shall given their sequence number in ASCII is 95 and 101 respectively.

However, following queries does not always yield `True` but `True` and `False` in different operating systems.

    SELECT '_' COLLATE "en_US" < 'e' COLLATE "en_US";
    
    SELECT 'lock_note' COLLATE "en_US" < 'locked_by' COLLATE "en_US";

I didn&rsquo;t some google search and the general impression I got is when locale is enabled, sorting in postgres leveraging locale rule from Operating System and the rules may vary cross OS, which could explain why aforementioned queries yields inconsistent result cross OS.

My actual problem to solve is to want same sorting result between postgres and my Application code and both run in same OS. A very quick skim to postgres source gives me impression that postgres utilize `ucol_strcollUTF8` when comes to UTF-8 sorting.
So I **assume** if my application code call `ucol_strcollUTF8`, it shall given same result as postgres.
I did POC (see details in `icu_string_comparison.c`) and I got following result, which is not same to postgres.

    "lock_note" is smaller than "locked_by"

Quick recap

<table>


<colgroup>
<col  class="org-left">

<col  class="org-left">
</colgroup>
<thead>
<tr>
<th scope="col" class="org-left">Code</th>
<th scope="col" class="org-left">Result</th>
</tr>
</thead>

<tbody>
<tr>
<td class="org-left"><code>SELECT 'lock_note' COLLATE "en_US" &lt; 'locked_by' COLLATE "en_US"</code></td>
<td class="org-left">False</td>
</tr>


<tr>
<td class="org-left">icu<sub>string</sub><sub>comparison.c</sub>: <code>'lock_note'</code> &lt; <code>'locked_by'</code></td>
<td class="org-left">True</td>
</tr>
</tbody>
</table>

So I probably missed something like sorting in postgres is not as simply as using `ucol_strcolUTF8` and something else.

