
#include "TreeItem.h"

#include "QDebug"

HwaTreeItem::HwaTreeItem(const QString& text)
	: _parent(NULL)
	, _flags(Qt::ItemIsSelectable | Qt::ItemIsUserCheckable | Qt::ItemIsEnabled)
{
	QVector<HwaItemData> column;
	column.append(HwaItemData(Qt::DisplayRole, text));

	_values.append(column);
}

HwaTreeItem::HwaTreeItem(const QIcon& icon, const QString& text)
	: _parent(NULL)
	, _flags(Qt::ItemIsSelectable | Qt::ItemIsUserCheckable | Qt::ItemIsEnabled)
{
	QVector<HwaItemData> column;
	column.append(HwaItemData(Qt::DisplayRole, text));
	column.append(HwaItemData(Qt::DecorationRole, icon));

	_values.append(column);
}

HwaTreeItem::HwaTreeItem()
	: _parent(NULL)
	, _flags(Qt::ItemIsSelectable | Qt::ItemIsUserCheckable | Qt::ItemIsEnabled)
{

}

HwaTreeItem::~HwaTreeItem()
{

}

QVariant HwaTreeItem::data(int column, int role /*= Qt::UserRole + 1*/) const
{
	if (column >= _values.size()) return QVariant();

    const QVector<HwaItemData>& itemDatas = _values[column];
	foreach (const HwaItemData& data, itemDatas)
    {
		if (data.role == role)
		{
			return data.value;
		}
	}

	return QVariant();
}

bool HwaTreeItem::setData(int column, const QVariant& value, int role /*= Qt::EditRole*/)
{
	if (column >= _values.size()) return false;

	QVector<HwaItemData>& itemDatas = _values[column];
	if (itemDatas.size() == 0)
	{
        itemDatas.push_back(HwaItemData(role, value));
	}
	else
	{
        //change role data
		bool flag = false;
		QVector<HwaItemData>::iterator iter = itemDatas.begin();
		for (; iter != itemDatas.end(); ++iter)
		{
			if ((*iter).role == role)
			{
				(*iter).value = value;
                flag = true;
				break;
			}
		}

		//不存在则添加此规则数据
        if (!flag)
        {
            itemDatas.push_back(HwaItemData(role, value));
        }
    }

	return true;
}

Qt::ItemFlags HwaTreeItem::flags() const
{
	return _flags;
}

void HwaTreeItem::insertChild(int row, HwaTreeItem* child)
{
	child->_parent = this;
	child->_values.resize(this->columnCount());
	_children.insert(row, child);
}

int HwaTreeItem::row() const
{
	return _parent == NULL ? 0 : _parent->indexOfChild((HwaTreeItem*)this);
}

int HwaTreeItem::indexOfChild(HwaTreeItem* child) const
{
	return _children.indexOf(child);
}

HwaTreeItem* HwaTreeItem::child(int index) const
{
	if (index < 0 || index >= _children.size()) return NULL;

	return _children.at(index);
}

void HwaTreeItem::removeChild(int index)
{
	_children.removeAt(index);
}
