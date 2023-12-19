-- CreateIndex
CREATE INDEX "Account_signPubkey_idx" ON "Account"("signPubkey");

-- CreateIndex
CREATE INDEX "Group_signPubkey_idx" ON "Group"("signPubkey");

-- CreateIndex
CREATE INDEX "GroupMembers_groupID_signPubkey_idx" ON "GroupMembers"("groupID", "signPubkey");

-- CreateIndex
CREATE INDEX "Message_signature_groupID_idx" ON "Message"("signature", "groupID");

-- CreateIndex
CREATE INDEX "Operation_accountID_clientId_clock_idx" ON "Operation"("accountID", "clientId", "clock");
