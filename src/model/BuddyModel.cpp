/*
 * BuddyModel.cpp
 *
 *  Created on: 03/04/2014
 *      Author: laairoy
 */

#include "BuddyModel.h"

#include <QUrl>
#include <QRegExp>

#include "protocol/platform.h"
#include "protocol/peer.h"

BuddyModel::BuddyModel() {
	// TODO Auto-generated constructor stub

}

BuddyModel::~BuddyModel() {
	// TODO Auto-generated destructor stub
}

void BuddyModel::addMeElement() {
	addBuddy("IP", 0, "IP connection", "Send data to a remote device", "IP",
			QUrl(""));
}

void BuddyModel::addBuddy(QString ip, qint16 port, QString username,
		QString system, QString platform, QUrl avatarPath) {
	//    QStandardItem* it = NULL;
	    QVariantMap it;
	    bool add = true;

	    // Check if the same IP is alreay in the buddy list
	    if (mItemsMap.contains(ip)) {
	        it = mItemsMap.value(ip).toMap();
	        add = false;
	    }
	    else
	    it["ip"] = ip;
	    it["port"] = port;
	    it["showback"] = false;

	    // Set (or update) data
	    it["username"] = username;
	    if (ip != "IP")
	        it["system"]= "at " + system;
	    else
	        it["system"]=system;
	    it["platform"]=platform;
	    it["avatar"]=avatarPath;

	    // Update generic avatar
	    if ((platform.toLower() == "symbian") || (platform.toLower() == "android") || (platform.toLower() == "ios") || (platform.toLower() == "blackberry") || (platform.toLower() == "windowsphone"))
	        it["generic"]= "SmartphoneLogo.png";
	    else if (platform.toLower() == "ip")
	        it["generic"]="IpLogo.png";
	    else
	        it["generic"]="PcLogo.png";

	    // Update logo
	    if (platform.toLower() == "windows")
	        it["oslogo"]="WindowsLogo.png";
	    else if (platform.toLower() == "macintosh")
	        it["oslogo"]="AppleLogo.png";
	    else if (platform.toLower() == "linux")
	        it["oslogo"]="LinuxLogo.png";
	    else if (platform.toLower() == "symbian")
	        it["oslogo"]="SymbianLogo.png";
	    else if (platform.toLower() == "ios")
	        it["oslogo"]="IosLogo.png";
	    else if (platform.toLower() == "windowsphone")
	        it["oslogo"]="WindowsPhoneLogo.png";
	    else if (platform.toLower() == "blackberry")
	        it["oslogo"]="BlackberryLogo.png";
	    else if (platform.toLower() == "android")
	        it["oslogo"]="AndroidLogo.png";
	    else
	        it["oslogo"]="UnknownLogo.png";

	    // Add elemento to the list
	    if (add) {
	    qDebug() << "controller::addBuddy:" << ip;
	        insert(it);
	        if (ip != "")
	        	mItemsMap.insert(ip, it);
	        else
	            mMeItem = it;
	    }
	    qDebug() << "controller::addBuddy:" << it;
}

void BuddyModel::addBuddy(Peer& peer) {
	qDebug() << "BuddyModel::addBuddy:" << peer.address.toString();
	QRegExp rx("^(.*)\\sat\\s(.*)\\s\\((.*)\\)$");
	rx.indexIn(peer.name);
	QStringList data = rx.capturedTexts();

	QString username = data[1];
	QString system = data[2];
	QString platform = data[3];
	QUrl avatarPath = QUrl(
			"http://" + peer.address.toString() + ":"
					+ QString::number(peer.port + 1) + "/dukto/avatar");

	addBuddy(peer.address.toString(), peer.port, username, system, platform,
			avatarPath);
}

void BuddyModel::addIpElement() {
	addBuddy("IP", 0, "IP connection", "Send data to a remote device", "IP",
			QUrl(""));
}

void BuddyModel::removeBuddy(QString ip) {
	 // Check for element
	    if (!mItemsMap.contains(ip)) return;

	    // Get element
	    QVariantMap it = mItemsMap.value(ip).toMap();

	    // Remove element
	    mItemsMap.remove(ip);
//	    this->removeRow(this->indexFromItem(it).row());
	    this->remove(it);
}

void BuddyModel::showSingleBack(int idx) {
}

void BuddyModel::updateMeElement() {
	mMeItem["username"] = Platform::getSystemUsername();
}

QString BuddyModel::buddyNameByIp(QString ip) {
	 if (!mItemsMap.contains(ip)) return "";
	    return mItemsMap.value(ip).toMap().value("username").toString();
}
