/**
* @date 2012-11-15-001
* @file TreeModel.cpp
* @author WeiJun Shi
*/
#include <QDebug>
#include <QJsonArray>
#include <QJsonObject>
#include <QJsonDocument>

#include "TreeItem.h"
#include "TreeModel.h"

HwaTreeModel::HwaTreeModel(QObject *parent)
: QAbstractItemModel(parent)
, _head(new HwaTreeItem)
{
    _head->setColumnCount(2);
    _head->setData(0, "A");
    _head->setData(1, "B");
    qDebug("Model constructed!");
}

HwaTreeModel::~HwaTreeModel()
{
}

int HwaTreeModel::columnCount(const QModelIndex&) const
{
    return _head->columnCount();
}

int HwaTreeModel::rowCount(const QModelIndex& parent) const
{
	HwaTreeItem* parentItem = NULL;
	if (!parent.isValid())
		parentItem = _head;
	else
		parentItem = static_cast<HwaTreeItem*>(parent.internalPointer());

	return parentItem->rowCount();
}

QVariant HwaTreeModel::data(const QModelIndex& index, int role) const
{
    if (!index.isValid())
    {
        return _head->columnCount() > 0 ? _head->data(0, role) : "column out range, model data()";
    }

    HwaTreeItem* item = (HwaTreeItem*)(index.internalPointer());
    return item->data(index.column(), role);
}

bool HwaTreeModel::setData(const QModelIndex & index, 
	const QVariant & value, int role)
{
	if (!index.isValid())
	{
		return _head->columnCount() > 0 ? _head->setData(0, value, role) : false;
	}

	HwaTreeItem* item = (HwaTreeItem*)(index.internalPointer());

	if (item != NULL)
    {
        item->setData(index.column(), value, role);
        if (role == Qt::EditRole)
            item->setData(index.column(), value, Qt::DisplayRole);

        //更新QML界面显示
        emit dataChanged(index, index);

		return true;
	}

	return false;
}

QModelIndex HwaTreeModel::index(int row, int column,
							 const QModelIndex & parent) const
{
	if (!hasIndex(row, column, parent))
		return QModelIndex();

	HwaTreeItem* parentItem = static_cast<HwaTreeItem*>(parent.internalPointer());
	if (parentItem == NULL) parentItem = _head;

	HwaTreeItem* childItem = parentItem->child(row);

	return childItem != NULL ? createIndex(row, column, childItem) : QModelIndex();
}

QModelIndex HwaTreeModel::parent(const QModelIndex& index) const
{
	if (!index.isValid())
	{
		return QModelIndex();
	}

	HwaTreeItem* childItem = (HwaTreeItem*)(index.internalPointer());
	HwaTreeItem* parentItem = childItem->parent();

    return parentItem == _head ? QModelIndex() : createIndex(parentItem->row(), index.column(), parentItem);
}

Qt::ItemFlags HwaTreeModel::flags(const QModelIndex & index) const
{
	HwaTreeItem* item = (HwaTreeItem*)(index.internalPointer());

	return item != NULL ? item->flags() : 0;
}

bool HwaTreeModel::insertRows(int row, int count, const QModelIndex& parent)
{
	HwaTreeItem* parentItem = NULL;
	if (!parent.isValid())
    {
        parentItem = _head;
    }
	else
		parentItem = (HwaTreeItem*)(parent.internalPointer());

	Q_ASSERT(parentItem != NULL);

	beginInsertRows(parent, row, row+count-1);
	for (int i=0; i<count; ++i)
    {
        parentItem->insertChild(row+i, new HwaTreeItem());
	}
	endInsertRows();

	return true;
}

bool HwaTreeModel::removeRows(int row, int count, const QModelIndex& parent)
{
	if (count == 0 || row < 0) return true;

	qDebug() << "remove rows";
	HwaTreeItem* item = NULL;
	if (!parent.isValid())
		item = _head;
	else
		item = (HwaTreeItem*)(parent.internalPointer());

	Q_ASSERT(item != NULL);
	beginRemoveRows(parent, row, row+count-1);
	for (int i=row+count-1; i>=row; --i)
	{
		item->removeChild(i);
	}
	endRemoveRows();

	return true;
}

QVariant HwaTreeModel::headerData(int section, Qt::Orientation orientation, int role /*= Qt::DisplayRole*/) const
{
	if (orientation == Qt::Horizontal && role == Qt::DisplayRole)
    {
		return _head->data(section, role);
	}

	return QVariant();
}

QHash<int,QByteArray> HwaTreeModel::roleNames() const
{
    QHash<int,QByteArray> roles = QAbstractItemModel::roleNames();

    roles.insert(Qt::DisplayRole, "display");
    roles.insert(Qt::DecorationRole, "decoration");
    roles.insert(Qt::EditRole, "edit");
    roles.insert(Qt::ToolTipRole, "toolTip");
    roles.insert(Qt::StatusTipRole, "statusTip");
    roles.insert(Qt::WhatsThisRole, "whatsThis");
    roles.insert(Qt::UserRole, "user0");
    roles.insert(Qt::UserRole+1, "user1");

    return roles;
}

void HwaTreeModel::setColumnsHeader(const QStringList& columns)
{
	if (columns.size() == 0) return;
	_head->setColumnCount(columns.size());
	for (int i=0; i<columns.size(); ++i)
	{
		_head->setData(i, columns[i]);
	}
}

QVariant HwaTreeModel::properties(const QModelIndex& index)
{
    return this->data(index, 1000);
}

bool HwaTreeModel::changeProperty(const QModelIndex& index, const QString& id, const QVariant& value)
{
    if (id == "name")
    {
        //修改节点名称
        this->setData(index, value);
    }

    auto props = QJsonObject::fromVariantMap(this->data(index, 1000).toMap());
    if (props.contains(id))
    {
        props[id] = QJsonValue::fromVariant(value);
        this->setData(index, props, 1000);

        return true;
    }

    return false;
}
