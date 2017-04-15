from flask import Flask, render_template, request
from core import AmazonPrice
import elasticemail
import config

app = Flask(__name__)
app.config.from_object(__name__)
app.debug = False

jinja_options = app.jinja_options.copy()
jinja_options.update(dict(
    block_start_string='<%',
    block_end_string='%>',
    variable_start_string='%%',
    variable_end_string='%%',
    comment_start_string='<#',
    comment_end_string='#>',
))
app.jinja_options = jinja_options


@app.route("/")
def main():
    return render_template(
        "index.html",
        ganalytics_tracking_id=config.GANALYTICS_TRACKING_ID
    )


@app.route("/ajax")
def ajax():
    raw_price = request.args.get("price", None, type=float)
    email_addr = request.args.get("email_addr", None)
    email_subject = request.args.get("email_subject", None)
    amazon_price = AmazonPrice(raw_price)

    buf = []
    if email_addr and email_subject:
        buf.append(
            """
            <p>
                Original price @ amazon.es: <strong>{:.2f}€</strong>
                <br>
                VAT excluded price:
                <strong>{:.2f}€</strong>
            </p>
            """.format(
                raw_price,
                amazon_price.vat_excluded_price
            )
        )
        buf.append("<ul>")
        for carrier, price in amazon_price.price_plus_customs.items():
            buf.append(
                "<li>{}: {:.2f}€ (customs included: {:.2f}€)</li>".format(
                    carrier, price, amazon_price.price_of_customs[carrier]
                )
            )
        buf.append("</ul>")
        buf.append("<p>http://ciap.codelia.net</p>")
        elasticemail.send(
            email_addr,
            email_subject,
            "".join(buf)
        )
        return ""
    else:
        return render_template("prices.html", amazon_price=amazon_price)


if __name__ == "__main__":
    app.debug = True
    app.run()
