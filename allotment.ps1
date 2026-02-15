# ==============================
# Gmail SMTP Configuration
# ==============================

$smtpServer = "smtp.gmail.com"
$smtpPort = 587
$username = "velconmun@gmail.com"
$password = $env:EMAIL_PASS
$from = "Velcon MUN <info@velconmun.in>"


# ==============================
# Take Inputs
# ==============================
# ==============================
# Committee Input
# ==============================

$committeeCode = Read-Host "Enter committee short form (UNGA UNEP AIPPM IPL IPC)"
$portfolio = Read-Host "Enter country or portfolio"

$committeeCode = $committeeCode.Trim().ToUpper()

$committeeMap = @{
    "UNGA"  = @{
        Name   = "United Nations General Assembly"
        Agenda = "Discussion on Improving Frameworks to Address the Global Women's Crisis"
    }
    "UNEP"  = @{
        Name   = "United Nations Environment Programme"
        Agenda = "Discussion on the Usage of Artificial Intelligence to Achieve Sustainable Development"
    }
    "AIPPM" = @{
        Name   = "All India Political Parties Meet"
        Agenda = "Discussion on Caste Based Politics with Emphasis on the Reservation Policy of India"
    }
    "IPL"   = @{
        Name   = "Indian Premier League"
        Agenda = "Mega Auction 2026 (Double Delegation)"
    }
    "IPC"   = @{
        Name   = "International Press Corps"
        Agenda = "Journalism, Caricature, Photography"
    }
}

if (-not $committeeMap.ContainsKey($committeeCode)) {
    Write-Host "Invalid committee code entered"
    exit
}

$committeeName = $committeeMap[$committeeCode].Name
$agenda = $committeeMap[$committeeCode].Agenda
$paymentInput = Read-Host "Has payment been received? (Y/N)"
$paymentInput = $paymentInput.Trim().ToUpper()
$toInput = Read-Host "Enter TO email addresses separated by commas"
$bccInput = Read-Host "Enter BCC email addresses separated by commas"

$to = $toInput -split "," | ForEach-Object { $_.Trim() }
$bcc = $bccInput -split "," | ForEach-Object { $_.Trim() }


# ==============================
# HTML Body
# ==============================

$invoice = @"
<div style="width:100%;max-width:760px;margin:auto;font-family:Arial,Helvetica,sans-serif;background:#f4fbf6;border-radius:14px;overflow:hidden;border:1px solid #cfe9d8">

  <!-- HEADER -->
  <div style="background:linear-gradient(135deg,#0f5132,#198754);padding:34px 28px;text-align:center;color:#ffffff">
    <img src="https://velconmun.in/velconmun.png" alt="Velcon MUN Logo" style="height:140px;margin-bottom:14px">

    <h1 style="margin:0;font-size:34px;letter-spacing:0.6px">
      Velcon Model United Nations 2026
    </h1>

    <p style="margin:8px 0 0;font-size:18px;opacity:0.95">
      Transaction Confirmation &amp; Payment Receipt
    </p>
  </div>

  <!-- BODY -->
  <div style="padding:40px;color:#1f2933;line-height:1.8">

    <h2 style="color:#198754;margin-top:0;font-size:30px">
      Payment Successfully Received!
    </h2>

    <p style="font-size:19px;font-weight:bold">Dear Delegate,</p>

    <p style="font-size:18px">
      We are delighted to inform you that your delegate fee for
      <strong>Velcon Model United Nations 2026</strong>
      has been <strong style="color:#198754">successfully received</strong>.
      This email serves as your official confirmation,
      and we are pleased to formally welcome you to the Velcon MUN family.
    </p>

    <div style="background:#e8f5ee;border-left:7px solid #198754;padding:22px;border-radius:10px;margin:26px 0">
      <p style="margin:0;font-size:18px">
        Your <strong>paid invoice and confirmation of payment</strong>
        have been attached with this email.
        The invoice stands as <strong>full and final confirmation</strong>
        of receipt of payment from our side.
      </p>
    </div>

    <p style="font-size:18px">
      You need not be worried in the slightest bit.
      The attached invoice is a <strong>legal document</strong>
      that attributes all applicable charges as credited and settled.
      At Velcon MUN, professionalism, transparency, and accountability
      are paramount.
    </p>

    <h3 style="color:#198754;font-size:22px;margin-bottom:8px">
      What Happens Next
    </h3>

    <p style="font-size:17.5px">
      All subsequent information pertaining to Velcon Model United Nations 2026,
      including but not limited to official guidance and training sessions,
      structured research support material,
      verified committee specific resources,
      formal conference schedules,
      venue and logistical arrangements,
      official WhatsApp group links,
      code of conduct briefings,
      and administrative or procedural updates,
      shall be communicated in a timely and systematic manner
      exclusively through authorized Velcon Model United Nations
      communication channels.
      The Secretariat remains committed to ensuring that every delegate
      is thoroughly informed, academically prepared,
      and procedurally supported at each stage prior to
      and throughout the duration of the conference,
      thereby upholding the highest standards of professionalism,
      institutional integrity, and delegate experience.
    </p>

    <h3 style="color:#198754;font-size:22px;margin-bottom:8px">
      Need Any Further Assistance
    </h3>

    <p style="font-size:17px">
      Our Delegate Affairs team is always available at
      <strong>delegateaffairs@velconmun.in</strong>.
      You may also reach out to your respective committee emails,
      such as <strong>unga@committees.velconmun.in</strong>.
    </p>

    <p style="margin-top:32px;font-size:18px">
      We look forward to your valuable participation and meaningful
      contribution at <strong>Velcon Model United Nations 2026</strong>.
    </p>

    <p style="margin-bottom:0;font-size:17px">
      Warm regards,<br>
      <strong>Team Velcon MUN</strong><br>
      Velcon Model United Nations 2026<br>
      Website: <a href="https://velconmun.in">https://velconmun.in</a><br>
      Email: info@velconmun.in, allotments@velconmun.in<br>
      Contact: Advik Jhamb (Founder), +91 9540902364
    </p>
  </div>

  <!-- FOOTER -->
  <div style="background-color:#f3f1ef;padding:20px;font-size:12px;color:#555555;line-height:1.6">
    <strong>Confidentiality Notice</strong><br>
    This email and any attachments are confidential and intended solely
    for the individual or entity addressed.
    If you are not the intended recipient any review disclosure copying
    distribution or use of this communication is strictly prohibited.
    If received in error please notify the sender immediately
    and delete this email from your system.
    Velcon Model United Nations reserves the right to monitor all
    communications transmitted through its networks.
    <p style="text-align:center;margin-top:15px;color:#777777">
      Copyright 2026 Velcon Model United Nations | All Rights Reserved
    </p>
  </div>

</div>
"@

$bodyPaid = @"
<table width="100%" cellpadding="0" cellspacing="0">
		<tbody>
			<tr>
				<td align="center" style="padding: 30px 10px">
					<table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 10px; overflow: hidden">
						<!-- Header -->
						<tbody>
							<tr>
								<td style="background-color: #8b1e1e; padding: 25px; text-align: center">
									<img src="https://velconmun.in/velconmun.png" alt="Velcon Model United Nations" style="max-width: 180px; display: block; margin: 0 auto 10px" jslog="138226; u014N:xr6bB; 53:WzAsMF0." />
									<h1 style="margin: 0; font-size: 24px; color: #ffffff; letter-spacing: 1px; font-family: serif">Velcon Model United Nations 2026</h1>
								</td>
							</tr>
							<!-- Body -->
							<tr>
								<td style="padding: 30px; color: rgb(51, 51, 51); line-height: 1.7">
									<p style="">
										<font size="4"><b>Dear Delegate,</b></font>
									</p>
									<p style="font-size: 15px">We are pleased to inform you that your delegate allotment for <b>Velcon Model United Nations 2026</b> has been successfully confirmed. The details of your assigned position are provided below subject to the conference terms and conditions.</p>
									<table width="100%" cellpadding="10" cellspacing="0" style="font-size: 15px; background-color: rgb(250, 247, 246); border-left: 4px solid rgb(139, 30, 30); margin: 20px 0px">
										<tbody>
											<tr>
												<td>
													<strong>Committee:</strong> $committeeName<br />
													<strong>Country/Portfolio:</strong> $portfolio<br />
													<strong>Agenda:</strong>&nbsp;$agenda
												</td>
											</tr>
										</tbody>
									</table>
									<p style="font-size: 15px">Your payment for the conference registration has been received. You will get an invoice for the same shortly from our email ID.</p>
									<p style="">
										<strong style=""><font size="4">Important Conference Details</font></strong>
									</p>
									<p style="font-size: 15px"><b> Conference Dates: </b>16th and 17th May, 2025<br /><b> Venue: </b>TBA, Faridabad, NCR</p>
									<p style="font-size: 15px">Should you require any clarification or assistance regarding your allotment or conference preparation feel free to reach out to the Secretariat.&nbsp;</p>
									
									<p style="font-size: 15px"><b>We look forward to your participation and valuable contribution at Velcon Model United Nations 2026. </b></p>
									<p style="font-size: 15px; margin-top: 30px">
										Warm regards,<br />
										<strong>Team Velcon MUN</strong><br />
										Velcon Model United Nations 2026<br />Website: <a href="https://velconmun.in">https://velconmun.in</a><br />Email: <a href="mailto:info@velconmun.in">info@velconmun.in</a>, <a href="mailto:allotments@velconmun.in">allotments@velconmun.in</a><br />Contact:&nbsp;Advik Jhamb (Founder), +91 9540902364
									</p>
								</td>
							</tr>
							<!-- Footer -->
							<tr>
								<td style="background-color: #f3f1ef; padding: 20px; font-size: 12px; color: #555555; line-height: 1.6">
									<strong>Confidentiality Notice</strong><br />
									This email and any attachments are confidential and intended solely for the individual or entity addressed. If you are not the intended recipient any review disclosure copying distribution or use of this communication is strictly prohibited. If received in error please notify the sender immediately and delete this email from your system. Velcon Model United Nations reserves the right to monitor all communications transmitted through its networks.
									<p style="text-align: center; margin-top: 15px; color: #777777">Copyright 2026 Velcon Model United Nations | All Rights Reserved</p>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
"@


$bodyUnpaid = @"
	<table width="100%" cellpadding="0" cellspacing="0">
		<tbody>
			<tr>
				<td align="center" style="padding: 30px 10px">
					<table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 10px; overflow: hidden">
						<!-- Header -->
						<tbody>
							<tr>
								<td style="background-color: #8b1e1e; padding: 25px; text-align: center">
									<img src="https://velconmun.in/velconmun.png" alt="Velcon Model United Nations" style="max-width: 180px; display: block; margin: 0 auto 10px" jslog="138226; u014N:xr6bB; 53:WzAsMF0." />
									<h1 style="margin: 0; font-size: 24px; color: #ffffff; letter-spacing: 1px; font-family: serif">Velcon Model United Nations 2026</h1>
								</td>
							</tr>
							<!-- Body -->
							<tr>
								<td style="padding: 30px; color: rgb(51, 51, 51); line-height: 1.7">
									<p style="">
										<font size="4"><b>Dear Delegate,</b></font>
									</p>
									<p style="font-size: 15px">We are pleased to inform you that your delegate allotment for <b>Velcon Model United Nations 2026</b> has been successfully confirmed. The details of your assigned position are provided below subject to the conference terms and conditions.</p>
									<table width="100%" cellpadding="10" cellspacing="0" style="font-size: 15px; background-color: rgb(250, 247, 246); border-left: 4px solid rgb(139, 30, 30); margin: 20px 0px">
										<tbody>
											<tr>
												<td>
                                                    <strong>Committee:</strong> $committeeName<br/>
													<strong>Country/Portfolio:</strong> $portfolio<br/>
													<strong>Agenda:</strong>&nbsp;$agenda
												</td>
											</tr>
										</tbody>
									</table>
									<p style="font-size: 15px">To complete your registration and secure your allotment kindly proceed with the payment of the delegate fee <b>within 24 hours of receiving this email</b>. The applicable registration amount and payment instructions have been shared separately. Please ensure that the payment is completed within the stipulated time frame. Failure to do so may result in cancellation of the allotted position.</p>
									<p style="">
										<strong style=""><font size="4">Important Conference Details</font></strong>
									</p>
									<p style="font-size: 15px"><b> Conference Dates: </b>16th and 17th May, 2025<br /><b> Venue: </b>TBA, Faridabad, NCR</p>
									<p style="font-size: 15px">Should you require any clarification or assistance regarding your allotment or conference preparation feel free to reach out to the Secretariat.&nbsp;</p>
									<table width="100%" cellpadding="12" cellspacing="0" style="font-size: 15px; background-color: #faf7f6; border: 1px solid #e2d6d3; border-radius: 6px; margin: 25px 0">
										<tr>
											<td colspan="2" style="padding-bottom: 10px">
												<strong>Registration Fee & Payment Details</strong>
											</td>
										</tr>

										<tr>
											<td colspan="2" style="padding-bottom: 15px">
												The amount to be paid for the registration of this committee is <strong>INR 1,999</strong>. The payment is fully inclusive of all conference charges including food (breakfast and lunch) on both days attending passes logistics, mementos if won and more. The payment is to be made at once via the QR code or UPI ID provided below. <b>After completing the payment, please mail your payment screenshot to payments@velconmun.in! </b> Once you have done the same, we will confirm your payment by sending you a proper legal receipt drafted by our financial team with more instructions outlining everything.<br /><br />
												<strong>NOTE:</strong> This application fee is an <strong>Early Bird Fee</strong> and is prone to increase at a future date. It is strongly recommended that you complete your payment and application at the earliest to avoid any hike in registration charges. The payment policy is linked below for reference. The conference legally declares that all funds received shall be used solely for conference related purposes. In the unlikely event of conference cancellation the full amount shall be refunded to all participants.
											</td>
										</tr>

										<tr><td width="100%" style="vertical-align: top">
												<strong>UPI ID:</strong> velconmun@ptaxis<br />
												<strong>Name on UPI Account:</strong> Anshika Jhamb<br />
                                                <strong>Breakdown of Charges:</strong> <a href="https://drive.google.com/file/d/1eUHyie99yOoEuhEzYjY6ahQtSqeF2tyG/view?usp=sharing" target="_blank"> View</a><br />
												<strong>Declaration of Truthfulness & Good Intent of Recipient:</strong> <a href="https://drive.google.com/file/d/1OATrLLpIbBwjLBybma77zo__RKbMhhgd/view?usp=drivesdk" target="_blank"> View</a><br />
												<strong>Declaration of Truthfulness & Good Intent of Account Owner:</strong> <a href="https://drive.google.com/file/d/11ENftKFN0yUfhtgRKtklXGLlbhqpeucX/view?usp=drivesdk" target="_blank"> View</a><br />
												<br />
												<strong>Full Payment Policy:</strong><br />
												<a href="https://docs.google.com/document/d/10IEifbiD4KyAWi0TD4yVqY2QRAMguYdxsBz7pvI9cDw/edit?usp=sharing" target="_blank"> View Payment Policy Document </a>
											</td>
										</tr>
																				<tr>
											<td width="100%" align="center" style="vertical-align: top">
												<div style="border: 1px solid #d3b5b0; padding: 10px; border-radius: 6px; background-color: #ffffff; width: 260px">
													<img src="https://velconmun.in/qr.png" alt="Velcon MUN Payment QR" style="width: 260px; height: auto; display: block; margin: 0 auto" />
												</div>
											</td></tr>
									</table>

									<p style="font-size: 15px"><b>We look forward to your participation and valuable contribution at Velcon Model United Nations 2026. </b></p>
									<p style="font-size: 15px; margin-top: 30px">
										Warm regards,<br />
										<strong>Team Velcon MUN</strong><br />
										Velcon Model United Nations 2026<br />Website: <a href="https://velconmun.in">https://velconmun.in</a><br />Email: <a href="mailto:info@velconmun.in">info@velconmun.in</a>, <a href="mailto:allotments@velconmun.in">allotments@velconmun.in</a><br />Contact:&nbsp;Advik Jhamb (Founder), +91 9540902364
									</p>
								</td>
							</tr>
							<!-- Footer -->
							<tr>
								<td style="background-color: #f3f1ef; padding: 20px; font-size: 12px; color: #555555; line-height: 1.6">
									<strong>Confidentiality Notice</strong><br />
									This email and any attachments are confidential and intended solely for the individual or entity addressed. If you are not the intended recipient any review disclosure copying distribution or use of this communication is strictly prohibited. If received in error please notify the sender immediately and delete this email from your system. Velcon Model United Nations reserves the right to monitor all communications transmitted through its networks.
									<p style="text-align: center; margin-top: 15px; color: #777777">Copyright 2026 Velcon Model United Nations | All Rights Reserved</p>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
"@

$bodyUnpaidIPL = @"
	<table width="100%" cellpadding="0" cellspacing="0">
		<tbody>
			<tr>
				<td align="center" style="padding: 30px 10px">
					<table width="600" cellpadding="0" cellspacing="0" style="background-color: #ffffff; border-radius: 10px; overflow: hidden">
						<!-- Header -->
						<tbody>
							<tr>
								<td style="background-color: #8b1e1e; padding: 25px; text-align: center">
									<img src="https://velconmun.in/velconmun.png" alt="Velcon Model United Nations" style="max-width: 180px; display: block; margin: 0 auto 10px" jslog="138226; u014N:xr6bB; 53:WzAsMF0." />
									<h1 style="margin: 0; font-size: 24px; color: #ffffff; letter-spacing: 1px; font-family: serif">Velcon Model United Nations 2026</h1>
								</td>
							</tr>
							<!-- Body -->
							<tr>
								<td style="padding: 30px; color: rgb(51, 51, 51); line-height: 1.7">
									<p style="">
										<font size="4"><b>Dear Delegate,</b></font>
									</p>
									<p style="font-size: 15px">We are pleased to inform you that your delegate allotment for <b>Velcon Model United Nations 2026</b> has been successfully confirmed. The details of your assigned position are provided below subject to the conference terms and conditions.</p>
									<table width="100%" cellpadding="10" cellspacing="0" style="font-size: 15px; background-color: rgb(250, 247, 246); border-left: 4px solid rgb(139, 30, 30); margin: 20px 0px">
										<tbody>
											<tr>
												<td>
                                                    <strong>Committee:</strong> $committeeName<br/>
													<strong>Country/Portfolio:</strong> $portfolio<br/>
													<strong>Agenda:</strong>&nbsp;$agenda
												</td>
											</tr>
										</tbody>
									</table>
									<p style="font-size: 15px">To complete your registration and secure your allotment kindly proceed with the payment of the delegate fee <b>within 24 hours of receiving this email</b>. The applicable registration amount and payment instructions have been shared separately. Please ensure that the payment is completed within the stipulated time frame. Failure to do so may result in cancellation of the allotted position.</p>
									<p style="">
										<strong style=""><font size="4">Important Conference Details</font></strong>
									</p>
									<p style="font-size: 15px"><b> Conference Dates: </b>16th and 17th May, 2025<br /><b> Venue: </b>TBA, Faridabad, NCR</p>
									<p style="font-size: 15px">Should you require any clarification or assistance regarding your allotment or conference preparation feel free to reach out to the Secretariat.&nbsp;</p>
									<table width="100%" cellpadding="12" cellspacing="0" style="font-size: 15px; background-color: #faf7f6; border: 1px solid #e2d6d3; border-radius: 6px; margin: 25px 0">
										<tr>
											<td colspan="2" style="padding-bottom: 10px">
												<strong>Registration Fee & Payment Details</strong>
											</td>
										</tr>

										<tr>
											<td colspan="2" style="padding-bottom: 15px">
												The amount to be paid for the registration of this committee is <strong>INR 3,998</strong>. This is equivalent to INR 1,999 per delegate, but has to be paid together on the QR. The payment is fully inclusive of all conference charges including food (breakfast and lunch) on both days attending passes logistics, mementos if won and more. The payment is to be made at once via the QR code or UPI ID provided below. <b>After completing the payment, please mail your payment screenshot to payments@velconmun.in! </b> Once you have done the same, we will confirm your payment by sending you a proper legal receipt drafted by our financial team with more instructions outlining everything.<br /><br />
												<strong>NOTE:</strong> This application fee is an <strong>Early Bird Fee</strong> and is prone to increase at a future date. It is strongly recommended that you complete your payment and application at the earliest to avoid any hike in registration charges. The payment policy is linked below for reference. The conference legally declares that all funds received shall be used solely for conference related purposes. In the unlikely event of conference cancellation the full amount shall be refunded to all participants.
											</td>
										</tr>

										<tr><td width="100%" style="vertical-align: top">
												<strong>UPI ID:</strong> velconmun@ptaxis<br />
												<strong>Name on UPI Account:</strong> Anshika Jhamb<br />
                                                <strong>Breakdown of Charges:</strong> <a href="https://drive.google.com/file/d/1eUHyie99yOoEuhEzYjY6ahQtSqeF2tyG/view?usp=sharing" target="_blank"> View</a><br />
												<strong>Declaration of Truthfulness & Good Intent of Recipient:</strong> <a href="https://drive.google.com/file/d/1OATrLLpIbBwjLBybma77zo__RKbMhhgd/view?usp=drivesdk" target="_blank"> View</a><br />
												<strong>Declaration of Truthfulness & Good Intent of Account Owner:</strong> <a href="https://drive.google.com/file/d/11ENftKFN0yUfhtgRKtklXGLlbhqpeucX/view?usp=drivesdk" target="_blank"> View</a><br />
												<br />
												<strong>Full Payment Policy:</strong><br />
												<a href="https://docs.google.com/document/d/10IEifbiD4KyAWi0TD4yVqY2QRAMguYdxsBz7pvI9cDw/edit?usp=sharing" target="_blank"> View Payment Policy Document </a>
											</td>
										</tr>
																				<tr>
											<td width="100%" align="center" style="vertical-align: top">
												<div style="border: 1px solid #d3b5b0; padding: 10px; border-radius: 6px; background-color: #ffffff; width: 260px">
													<img src="https://velconmun.in/qr.png" alt="Velcon MUN Payment QR" style="width: 260px; height: auto; display: block; margin: 0 auto" />
												</div>
											</td></tr>
									</table>

									<p style="font-size: 15px"><b>We look forward to your participation and valuable contribution at Velcon Model United Nations 2026. </b></p>
									<p style="font-size: 15px; margin-top: 30px">
										Warm regards,<br />
										<strong>Team Velcon MUN</strong><br />
										Velcon Model United Nations 2026<br />Website: <a href="https://velconmun.in">https://velconmun.in</a><br />Email: <a href="mailto:info@velconmun.in">info@velconmun.in</a>, <a href="mailto:allotments@velconmun.in">allotments@velconmun.in</a><br />Contact:&nbsp;Advik Jhamb (Founder), +91 9540902364
									</p>
								</td>
							</tr>
							<!-- Footer -->
							<tr>
								<td style="background-color: #f3f1ef; padding: 20px; font-size: 12px; color: #555555; line-height: 1.6">
									<strong>Confidentiality Notice</strong><br />
									This email and any attachments are confidential and intended solely for the individual or entity addressed. If you are not the intended recipient any review disclosure copying distribution or use of this communication is strictly prohibited. If received in error please notify the sender immediately and delete this email from your system. Velcon Model United Nations reserves the right to monitor all communications transmitted through its networks.
									<p style="text-align: center; margin-top: 15px; color: #777777">Copyright 2026 Velcon Model United Nations | All Rights Reserved</p>
								</td>
							</tr>
						</tbody>
					</table>
				</td>
			</tr>
		</tbody>
	</table>
"@



if ($paymentInput -eq "Y") {
    $body = $bodyPaid
    $subject = "Paid Allotment Confirmation | Velcon MUN 2026"
}
elseif ($paymentInput -eq "N") {
    if ($committeeName -eq "Indian Premier League") {
        $body = $bodyUnpaidIPL
        $subject = "Allotment & Payment Details IPL | Velcon MUN 2026"
    }
    else {
        $body = $bodyUnpaid
        $subject = "Allotment & Payment Details | Velcon MUN 2026"
    }
}
elseif ($paymentInput -eq "I") {
    $body = $invoice
    $subject = "Payment Confirmation | Velcon MUN 2026"
}
else {
    Write-Host "Invalid input. Please enter Y or N only."
    exit
}


# ==============================
# Credentials
# ==============================

$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# ==============================
# Send Email
# ==============================

Send-MailMessage `
    -To $to `
    -Bcc $bcc `
    -From $from `
    -Subject $subject `
    -Body $body `
    -BodyAsHtml `
    -SmtpServer $smtpServer `
    -Port $smtpPort `
    -UseSsl `
    -Credential $credential

Write-Host "Email sent successfully."
